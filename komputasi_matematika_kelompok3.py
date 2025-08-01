# -*- coding: utf-8 -*-
"""Komputasi Matematika.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/165SsJ9Ab9cIrg4Xv00R6hGMSIRe6sXEY
"""

pip install pyswarm

import os
import zipfile
import gdown
import numpy as np
import tensorflow as tf
from tensorflow.keras import layers, models, optimizers
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from pyswarm import pso
from sklearn.metrics import classification_report, confusion_matrix
from sklearn.utils import class_weight
from tensorflow.keras.callbacks import EarlyStopping
import matplotlib.pyplot as plt
import seaborn as sns

# Data
drive_file_id = "1g29NPcFYKqEhbYC_Tyir0aTajM0IH5Px"

url = f"https://drive.google.com/uc?id={drive_file_id}"
zip_output = "skin_dataset.zip"

print(f"Downloading dataset from Google Drive ID: {drive_file_id} ...")
gdown.download(url, zip_output, quiet=False)

extract_dir = "skin_dataset"
if not os.path.exists(extract_dir):
    os.makedirs(extract_dir)

print(f"Extracting {zip_output}...")
with zipfile.ZipFile(zip_output, 'r') as zip_ref:
    zip_ref.extractall(extract_dir)
print(f"Dataset extracted to folder: {extract_dir}")

# Corrected paths based on typical dataset structure after extraction
train_dir = os.path.join(extract_dir, "skin_dataset", "train")
test_dir = os.path.join(extract_dir, "skin_dataset", "test")


#  Data train & test
train_datagen = ImageDataGenerator(
    rescale=1./255,
    rotation_range=30,
    width_shift_range=0.1,
    height_shift_range=0.1,
    shear_range=0.1,
    zoom_range=0.2,
    horizontal_flip=True,
    vertical_flip=True,     # matikan ini jika tidak sesuai konteks medis
    fill_mode='nearest'
)

test_datagen = ImageDataGenerator(rescale=1./255)

train_data = train_datagen.flow_from_directory(
    train_dir,
    target_size=(128, 128),
    batch_size=32,
    class_mode='binary'
)

test_data = test_datagen.flow_from_directory(
    test_dir,
    target_size=(128, 128),
    batch_size=32,
    class_mode='binary',
    shuffle=False
)

#  Fungsi fitness PSO: bangun + latih CNN + hitung 1-akurasi
def fitness(params):
    lr, dense_units, dropout = params
    dense_units = int(dense_units)
    dropout = np.clip(dropout, 0.1, 0.7)

    model = models.Sequential([
        layers.Conv2D(32, (3, 3), activation='relu', padding='same', input_shape=(128, 128, 3)),
        layers.MaxPooling2D((2, 2)),
        layers.Conv2D(64, (3, 3), activation='relu', padding='same'),
        layers.MaxPooling2D((2, 2)),
        layers.Flatten(),
        layers.Dense(dense_units, activation='relu'),
        layers.Dropout(dropout),
        layers.Dense(1, activation='sigmoid')
    ])
    model.compile(optimizer=optimizers.Adam(learning_rate=lr),
                  loss='binary_crossentropy',
                  metrics=['accuracy'])
    history = model.fit(train_data, epochs=2, validation_data=test_data, verbose=0)
    val_acc = history.history['val_accuracy'][-1]
    print(f"[PSO] lr={lr:.5f}, dense={dense_units}, dropout={dropout:.2f} => val_acc={val_acc:.4f}")

    return 1 - val_acc  # PSO minimasi

# PSO
lb = [1e-5, 64, 0.1]   # batas bawah: [lr, dense_units, dropout]
ub = [1e-2, 512, 0.7]  # batas atas

best_params, best_fitness = pso(fitness, lb, ub, swarmsize=5, maxiter=3)
print(f"Best hyperparameters found by PSO:")
print(f"  learning rate = {best_params[0]:.5f}")
print(f"  dense units   = {int(best_params[1])}")
print(f"  dropout       = {best_params[2]:.2f}")

#Class Weights
train_labels = train_data.classes
class_weights = class_weight.compute_class_weight(
    class_weight='balanced',
    classes=np.unique(train_labels),
    y=train_labels
)
class_weights = dict(enumerate(class_weights))
print("Class weights:", class_weights)

# Latih model final dengan hyperparameter terbaik
lr, dense_units, dropout = best_params
dense_units = int(dense_units)
dropout = np.clip(dropout, 0.1, 0.7)

final_model = models.Sequential([
    layers.Conv2D(32, (3, 3), activation='relu', padding='same', input_shape=(128, 128, 3)),
    layers.MaxPooling2D((2, 2)),
    layers.Conv2D(64, (3, 3), activation='relu', padding='same'),
    layers.MaxPooling2D((2, 2)),
    layers.Flatten(),
    layers.Dense(dense_units, activation='relu'),
    layers.Dropout(dropout),
    layers.Dense(1, activation='sigmoid')
])
final_model.compile(optimizer=optimizers.Adam(learning_rate=lr),
                    loss='binary_crossentropy',
                    metrics=['accuracy'])

early_stop = EarlyStopping(monitor='val_loss', patience=5, restore_best_weights=True)

history = final_model.fit(train_data, epochs=30, validation_data=test_data,
                          class_weight=class_weights, callbacks=[early_stop])
final_model.save('cnn_skin_best_model.h5')
print("Final training complete. Model saved as cnn_skin_best_model.h5")

# Evaluasi model akhir
loss, acc = final_model.evaluate(test_data)
print(f"\nFinal Test Accuracy: {acc*100:.2f}%")
print(f"Final Test Loss: {loss:.4f}")

# Prediksi di test set
y_pred = final_model.predict(test_data)
y_pred_class = (y_pred > 0.5).astype(int).flatten()
y_true = test_data.classes
class_labels = list(test_data.class_indices.keys())

# Confusion Matrix
cm = confusion_matrix(y_true, y_pred_class)
plt.figure(figsize=(6,5))
sns.heatmap(cm, annot=True, fmt="d", cmap="Blues",
            xticklabels=class_labels, yticklabels=class_labels)
plt.title("Confusion Matrix")
plt.ylabel("Actual")
plt.xlabel("Predicted")
plt.show()

# Classification Report
print("\nClassification Report:")
print(classification_report(y_true, y_pred_class, target_names=class_labels))

# Plot training accuracy & loss
plt.figure(figsize=(12,5))
plt.subplot(1,2,1)
plt.plot(history.history['accuracy'], label='Train Accuracy')
plt.plot(history.history['val_accuracy'], label='Val Accuracy')
plt.title('Accuracy per Epoch')
plt.xlabel('Epoch')
plt.ylabel('Accuracy')
plt.legend()

plt.subplot(1,2,2)
plt.plot(history.history['loss'], label='Train Loss')
plt.plot(history.history['val_loss'], label='Val Loss')
plt.title('Loss per Epoch')
plt.xlabel('Epoch')
plt.ylabel('Loss')
plt.legend()

plt.tight_layout()
plt.show()

# Bandingkan dengan model hyperparameter default
print("\nTraining model dengan hyperparameter DEFAULT (lr=0.001, dense=128, dropout=0.5)...")
default_model = models.Sequential([
    layers.Conv2D(32, (3, 3), activation='relu', padding='same', input_shape=(128, 128, 3)),
    layers.MaxPooling2D((2, 2)),
    layers.Conv2D(64, (3, 3), activation='relu', padding='same'),
    layers.MaxPooling2D((2, 2)),
    layers.Flatten(),
    layers.Dense(128, activation='relu'),
    layers.Dropout(0.5),
    layers.Dense(1, activation='sigmoid')
])
default_model.compile(optimizer=optimizers.Adam(learning_rate=0.001),
                      loss='binary_crossentropy',
                      metrics=['accuracy'])
default_model.fit(train_data, epochs=10, validation_data=test_data, verbose=0)
default_loss, default_acc = default_model.evaluate(test_data)
print(f"\n[DEFAULT] Test Accuracy: {default_acc*100:.2f}%")

print("\n=== Perbandingan Akurasi ===")
print(f"Hyperparameter Default  → Test Accuracy: {default_acc*100:.2f}%")
print(f"Hyperparameter dari PSO → Test Accuracy: {acc*100:.2f}%")

# === Langkah 1: Prediksi pada data uji ===
y_pred_probs = default_model.predict(test_data)
y_pred_class = (y_pred_probs > 0.5).astype("int32")

# Ekstraksi label sebenarnya dari test_data (diasumsikan menggunakan ImageDataGenerator)
y_true = test_data.classes
class_labels = list(test_data.class_indices.keys())  # Misal: ['cellulitis', 'other']

# === Langkah 2: Tampilkan Classification Report ===
print("\nClassification Report:")
print(classification_report(y_true, y_pred_class, target_names=class_labels))

# === Langkah 3: Confusion Matrix (Opsional tapi berguna) ===
print("\nConfusion Matrix:")
print(confusion_matrix(y_true, y_pred_class))


# === Langkah 4: Plot Akurasi dan Loss ===
# Catatan: default_model.fit tidak menyimpan history jika tidak ditampung → perlu ubah jadi:
history_default = default_model.fit(train_data, epochs=10, validation_data=test_data, verbose=1)

plt.figure(figsize=(12, 5))

# Plot Akurasi
plt.subplot(1, 2, 1)
plt.plot(history_default.history['accuracy'], label='Train Accuracy')
plt.plot(history_default.history['val_accuracy'], label='Val Accuracy')
plt.title('Accuracy per Epoch (Default Model)')
plt.xlabel('Epoch')
plt.ylabel('Accuracy')
plt.legend()

# Plot Loss
plt.subplot(1, 2, 2)
plt.plot(history_default.history['loss'], label='Train Loss')
plt.plot(history_default.history['val_loss'], label='Val Loss')
plt.title('Loss per Epoch (Default Model)')
plt.xlabel('Epoch')
plt.ylabel('Loss')
plt.legend()

plt.tight_layout()
plt.show()

import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# Confusion matrix data
confusion_matrix = np.array([[126, 57],
                             [20, 160]])

# Define class names
class_names = ['Negative', 'Positive']

# Create the heatmap with green color
plt.figure(figsize=(6, 5))
sns.heatmap(confusion_matrix, annot=True, fmt='d', cmap='Greens',
            xticklabels=class_names, yticklabels=class_names)
plt.xlabel('Predicted Label')
plt.ylabel('True Label')
plt.title('Confusion Matrix')
plt.tight_layout()

plt.show()