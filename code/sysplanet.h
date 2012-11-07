#pragma once
struct sysplanet {
	struct planet planet;
	char * file;
	TAILQ_ENTRY(sysplanet) _;
};

