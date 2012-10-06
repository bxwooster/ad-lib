int gl_init ();
char const * gl_shader_prefix ();
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
void translatematrix (float matrix [4 * 4], float move [3]);
int loadplanet (struct planet * planet, char const * file);
void planetmatrix (
		struct planet const * planet,
		double time,
		float const mcam [4 * 4],
		float mmodel [4 * 4],
		float mrot [4 * 4],
		float * tosurface,
		float * apparentratio);
void logi(char const * fmt, ...);
int loadsettings (struct settings * settings, char const * file);
int loadshader (struct shader_t * shader, char const * file);
void logshader (GLuint sh);
void vectorsum (
	float const a [3],
	float const b [3],
	float out [3]);

void vectordiff (
	float const a [3],
	float const b [3],
	float out [3]);

void vectorproduct (
	float const a [3],
	float const b [3],
	float out [3]);

float vectorlength (float const v [3]);

void vectorscale (float v[3], float scale); 
void vectornormalize (float v [3]);

