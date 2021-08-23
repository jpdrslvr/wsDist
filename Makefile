clean:
	@rm -f R/exports.R

export: clean
	@for dist in exp  gam  gev  glo  gno  gpa  gum_min  gum_max  kap  ln3  nor  pe3  wak  wei ; do \
		for met in density_function prob_function q_function ; do \
			echo "#' @exportS3Method $${met} $${dist} \nNULL\n" >> R/exports.R; \
		done \
	done

document: export
	@echo "- Atualizando documentação\n" ;\
	Rscript -e "devtools::document()"

install: document
	@echo "\n- Instalando\n" ;\
	cd ..;\
	R CMD INSTALL --no-multiarch --with-keep.source wsDist
