% TUGAS 4 KOMPUTASI MATEMATIKA %

% 1
% % z = x1^2 + x2^2
% % batas -10<=x1<=10
% % batas -10<=x2<=10
% x1 = (-10:1:10)
% x2 = (-10:4:10)
% [x1,x2] = meshgrid(x1,x2)
% z = x1.^2 + x2.^2
% figure(1)
% mesh(x1,x2,z)
% figure(2)
% surf(x1,x2,z)

% 2
% u = linspace(0, 2*pi, 100);
% v = linspace(0, 2*pi, 100);
% [U, V] = meshgrid(u, v);
% 
% R = 3; r = 1; % Radius besar dan kecil
% X = (R + r.*cos(V)) .* cos(U);
% Y = (R + r.*cos(V)) .* sin(U);
% Z = r .* sin(V) + 0.5*sin(5*U); % Ditambahkan gelombang
% 
% surf(X, Y, Z)
% shading interp
% colormap(parula)
% axis equal
% title('Toroidal Wave Surface')

% 3
% subplot(3,3,3)
% [u,v] = meshgrid(linspace(0,pi,100), linspace(0,2*pi,100));
% X = 16*sin(u).^3;
% Y = 13*cos(u) - 5*cos(2*u) - 2*cos(3*u) - cos(4*u);
% Z = 2*sin(v);
% surf(X,Y,Z), shading interp, colormap spring
% title('Surface');

% 4
% subplot(3,3,4)
% theta = linspace(0, 20*pi, 2000);
% z = linspace(-2, 2, 2000);
% x = sin(theta).*z;
% y = cos(theta).*z;
% plot3(x,y,z,'g'), grid on
% title('Spiral Rumput Laut');

% 5
% [x, y, z] = meshgrid(linspace(-2, 2, 100));
% v = sin(pi*x) .* cos(pi*y) .* sin(pi*z);
% 
% slice(x, y, z, v, [0], [0], [-2 0 2])
% shading interp; colormap(autumn); colorbar
% title('4D Scalar Field View')

% 6
% theta = linspace(0, 2*pi, 100);
% phi = linspace(0, 2*pi, 100);
% [Theta, Phi] = meshgrid(theta, phi);
% 
% R = 1; r = 0.3;
% X = (R + r*cos(3*Theta)) .* cos(Phi);
% Y = (R + r*cos(3*Theta)) .* sin(Phi);
% Z = r * sin(3*Theta);
% 
% surf(X, Y, Z, 'EdgeColor', 'none');
% colormap(hsv); lighting phong; axis equal
% title('Twisted Torus')

% 7
% theta = linspace(0, 2*pi, 100);
% w = linspace(-0.3, 0.3, 20);
% [Theta, W] = meshgrid(theta, w);
% 
% R = 1 + W .* cos(Theta/2);
% X = R .* cos(Theta);
% Y = R .* sin(Theta);
% Z = W .* sin(Theta/2);
% 
% surf(X, Y, Z, 'EdgeColor', 'none');
% colormap(cool); axis equal
% title('M?bius Strip')

% 8
% theta = linspace(0, pi, 100);
% phi = linspace(0, 2*pi, 100);
% [Theta, Phi] = meshgrid(theta, phi);
% 
% X = sin(Theta).*cos(Phi);
% Y = sin(Theta).*sin(Phi);
% Z = cos(Theta);
% C = sin(3*Theta).*cos(5*Phi);  % Warna = dimensi ke-4
% 
% surf(X, Y, Z, C, 'EdgeColor', 'none');
% colormap(hot); axis equal
% title('Color on Sphere 4D')

% 9 
% theta = linspace(-pi/2, pi/2, 100);
% phi = linspace(-pi, pi, 100);
% [Theta, Phi] = meshgrid(theta, phi);
% 
% e = 0.5;
% X = sign(cos(Theta)) .* abs(cos(Theta)).^e .* sign(cos(Phi)) .* abs(cos(Phi)).^e;
% Y = sign(cos(Theta)) .* abs(cos(Theta)).^e .* sign(sin(Phi)) .* abs(sin(Phi)).^e;
% Z = sign(sin(Theta)) .* abs(sin(Theta)).^e;
% 
% surf(X, Y, Z, 'EdgeColor', 'none');
% colormap(pink); axis equal
% title('Superquadric Surface')

% 10
% [x, y, z] = sphere(100);
% x = x .* (1 + 0.3*y.^2);
% y = y .* (1 + 0.3*z.^2);
% z = z .* (1 + 0.3*x.^2);
% surf(x, y, z, 'EdgeColor', 'none')
% colormap(cool); title('Kubus Melengkung'); axis equal

% 11
% theta = linspace(0, 2*pi, 100);
% phi = linspace(0, 2*pi, 100);
% [Theta, Phi] = meshgrid(theta, phi);
% R = 1 + 0.3 * sin(6*Theta + 4*Phi);
% X = R .* cos(Theta);
% Y = R .* sin(Theta);
% Z = 0.3 * cos(4*Phi);
% surf(X, Y, Z, 'EdgeColor', 'none');
% colormap(hsv); title('Donat Bunga'); axis equal

% 12
% [x, y] = meshgrid(linspace(-3,3,200));
% z = exp(-0.1*(x.^2 + y.^2)) .* sin(3*x) .* cos(3*y);
% surf(x, y, z, 'EdgeColor', 'none')
% colormap(spring); title('Permukaan Lonjong Berlapis'); axis equal

% 13
% [z, theta] = meshgrid(linspace(-1,1,100), linspace(0, 4*pi, 100));
% r = 1 + 0.2*sin(6*z);
% X = r .* cos(theta);
% Y = r .* sin(theta);
% Z = z;
% surf(X, Y, Z, 'EdgeColor', 'none')
% colormap(copper); title('Silinder Berputar'); axis equal

% 14
% [theta, r] = meshgrid(linspace(0, 4*pi, 400), linspace(0, 1, 100));
% X = r .* cos(theta) .* (1 + 0.2 * sin(10*theta));
% Y = r .* sin(theta) .* (1 + 0.2 * sin(10*theta));
% Z = r;
% surf(X, Y, Z, theta, 'EdgeColor', 'none')
% colormap(pink); title('Corong Spiral'); axis equal

% 15
% t = linspace(0, 12*pi, 1000);
% x = sin(t) .* (exp(cos(t)) - 2*cos(4*t) - sin(t/12).^5);
% y = cos(t) .* (exp(cos(t)) - 2*cos(4*t) - sin(t/12).^5);
% z = sin(0.1*t);
% plot3(x, y, z, 'm', 'LineWidth', 1.5);
% grid on; axis equal; title('Kupu-Kupu Parametrik')

% 16
% [x, y] = meshgrid(linspace(-2,2,200));
% z = sin(3*x).*cos(3*y) + cos(3*x).*sin(3*y);
% surf(x, y, z, 'EdgeColor', 'none')
% colormap(cool); title('Permukaan Puzzle'); axis equal

% 17
% [z, theta] = meshgrid(linspace(-1,1,100), linspace(0, 2*pi, 100));
% r = 1;
% X = r * cos(theta);
% Y = r * sin(theta);
% Z = z;
% C = sin(5*theta);
% surf(X, Y, Z, C, 'EdgeColor', 'none')
% colormap(summer); title('Silinder Bergaris'); axis equal

% 18
% [theta, phi] = meshgrid(linspace(0, pi, 200), linspace(0, 2*pi, 200));
% r = 1 + 0.4*sin(5*phi).*sin(3*theta);
% X = r .* sin(theta) .* cos(phi);
% Y = r .* sin(theta) .* sin(phi);
% Z = r .* cos(theta);
% C = sin(3*theta).*cos(5*phi);  % Dimensi 4D dalam warna
% surf(X, Y, Z, C, 'EdgeColor', 'none');
% colormap(hsv); title('Bintang 4D'); axis equal

%19
% theta = linspace(0, 2*pi, 1000);
% r = 1 + 0.4*cos(6*theta);
% x = r .* cos(theta);
% y = r .* sin(theta);
% z = 0.3*sin(12*theta);
% plot3(x, y, z, 'LineWidth', 1.5)
% axis equal; title('Kepingan Es Parametrik'); grid on

%20
% [x, y] = meshgrid(linspace(-3,3,150));
% z = sin(x) .* cos(y);
% c = cos(4*x) .* sin(4*y);
% surf(x, y, z, c, 'EdgeColor', 'none')
% colormap(winter); title('Gelombang 4D'); axis equal

