void invertspecialmatrix(float matrix [4 * 4]) {
    float a = matrix[1];
    float b = matrix[2];
    float c = matrix[6];

    matrix[1] = matrix[4];
    matrix[2] = matrix[8];
    matrix[6] = matrix[9];

    matrix[4] = a;
    matrix[8] = b;
    matrix[9] = c;

    float x = -matrix[12];
    float y = -matrix[13];
    float z = -matrix[14];

    matrix[12] = matrix[0] * x + matrix[4] * y + matrix[ 8] * z;
    matrix[13] = matrix[1] * x + matrix[5] * y + matrix[ 9] * z;
    matrix[14] = matrix[2] * x + matrix[6] * y + matrix[10] * z;
}

