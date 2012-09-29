void identitymatrix (float matrix [4 * 4]);
void projectionmatrix (
	float fov,
	float aspect,
	float near,
	float matrix [4 * 4]);
void invertspecialmatrix (float matrix [4 * 4]);
void multiplymatrix (float matrix [4 * 4], float another [4 * 4]);
void scalematrix (float matrix [4 * 4], float scale);
void rotatematrix (float matrix [4 * 4], float angle, float axis [3]);

