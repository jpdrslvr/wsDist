all: install

clean:
	@rm -f R/exports.R

export: clean
	@for dist in  gam  gev  glo  gno  gpa  gum_min  gum_max  kap  ln3  nor  pe3  wak  wei ; do \
		for met in density_function prob_function q_function ; do \
			echo "#' @exportS3Method $${met} $${dist} \nNULL\n" >> R/exports.R; \
		done \
	done

readme:
	@echo "\033[92m\n- Gerando README\033[0m\n" ;\
	Rscript --vanilla -e "library(knitr); knitr::knit('README.Rmd', 'README.md', quiet = TRUE)"

document: export
	@echo "\033[92m- Atualizando documentação\033[0m\n" ;\
	Rscript --vanilla -e "devtools::document()"

install: document
	@echo "\033[92m\n- Instalando\033[0m\n" ;\
	cd ..;\
	R CMD INSTALL --no-multiarch --with-keep.source wsDist;\
	cd wsDist;\
	$(MAKE) -s readme

install-github:
	Rscript -e "devtools::install_github('jpdrslvr/wsDist')"
