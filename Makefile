.PHONY: docker-status docker-stop docker-rm docker-clean-images docker-clean-containers docker-clean-builds docker-clean-volumes docker-clean-networks docker-clean-all docker-disk-usage docker-data-build docker-data-run docker-data-clean clean-data-parquet docker-volume-list git-init

# Zobrazí status běžících kontejnerů
docker-status:
	docker ps

# Zobrazí všechny kontejnery (i zastavené)
docker-status-all:
	docker ps -a

# Zastaví všechny běžící kontejnery
docker-stop:
	docker stop $$(docker ps -q) || true

# Odstraní všechny kontejnery
docker-rm: docker-stop
	docker rm $$(docker ps -a -q) || true

# Vyčistí nepoužívané obrazy
docker-clean-images:
	docker image prune -a -f

# Vyčistí nepoužívané kontejnery
docker-clean-containers:
	docker container prune -f

# Vyčistí všechny buildy
docker-clean-builds:
	docker buildx prune -a -f

# Vyčistí nepoužívané volumes
docker-clean-volumes:
	docker volume prune -f

# Vyčistí nepoužívané sítě
docker-clean-networks:
	docker network prune -f

# Kompletní vyčištění Docker prostředí (kontejnery, obrazy, volumes, sítě, buildy)
docker-clean-all: docker-rm
	docker system prune -a -f --volumes
	docker buildx prune -a -f

# Zobrazí využití disku Dockerem
docker-disk-usage:
	docker system df

# Sestaví Docker image pro generování dat
docker-data-build:
	docker build -t anyedustack2-data-generator .

# Spustí kontejner pro generování dat s napojením na lokální adresář
docker-data-run: docker-data-build
	docker run --name anyedustack2-data-generator -v $(PWD)/data:/app/data anyedustack2-data-generator

# Vyčistí kontejner a image pro generování dat
docker-data-clean:
	docker rm -f anyedustack2-data-generator 2>/dev/null || true
	docker rmi -f anyedustack2-data-generator 2>/dev/null || true

# Vyčistí adresář data
clean-data-parquet:
	rm -rf ./data/*.parquet
	@echo "Adresář data byl vyčištěn"

docker-volume-list:
	docker volume ls
	
# Vytvoří a inicializuje Git repozitář v adresáři tvého projektu
git-init:
	git init
	git add .
	git commit -m "Initial commit"
	git branch -M main
	git remote add origin https://github.com/msm00/AnyEduStack2.git
	git push -u origin main