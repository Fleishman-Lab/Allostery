% MATLAB Script to Compute the Solution for EA2B matrix

% Symbolic variables
syms k1 k_1 k2 k_2 k3 k_3 k4 k_4 k5 k_5 k6 k_6 k7 a b A B ET;

% The coefficient matrix 
coeff_matrix = [
    k1*A,              -(k4*B + k_1 + a*k1*A),   b*k_1,         0,              k_4,                0;
    0,                 a*k1*A,                  -(b*k_1 + k5*B), 0,             0,                  k_5;
    k2*B,              0,                       0,              -(k_2 + k3*A),  k_3,                0;
    0,                 k4*B,                    0,              k3*A,          -(k_3 + k_4 + k6*A), k_6;
    0,                 0,                       k5*B,           0,              k6*A,              -(k_6 + k_5 + k7);
    1,                 1,                       1,              1,              1,                  1
    ];

% The constant vector
constants = [0; 0; 0; 0; 0; ET];

% Computing the determinant of the coefficient matrix
det_A = det(coeff_matrix);
disp('Determinant of A computed.');

% Calculating the solution for EA2B using Cramer's Rule
temp_matrix = coeff_matrix;       % Copy the coefficient matrix
temp_matrix(:, 6) = constants;    % Replace the 6th column with the constants
det_A6 = det(temp_matrix);        % Compute determinant of modified matrix
solution_EA2B = simplify(det_A6 / det_A); % Compute solution for EA2B

% Extracting numerator and denominator
[numerator_expr, denominator_expr] = numden(solution_EA2B);

% Collect terms with respect to A, a, b for both numerator and denominator
collected_num = collect(numerator_expr, [A, a, b]);
collected_den = collect(denominator_expr, [A, a, b]);

% Simplify the full expression (numerator/denominator)
simplified_expr = collected_num / collected_den;

% Display the simplified expression
disp('Simplified EA2B_expression:')
disp(simplified_expr)

% Save EA2B to a separate file
ea2b_file = fopen('EA2B_expression.txt', 'w');
fprintf(ea2b_file, 'EA2B_expression = %s\n', char(simplified_expr)); % Save the simplified expression
fclose(ea2b_file);
disp('EA2B saved to "EA2B_expression.txt".');