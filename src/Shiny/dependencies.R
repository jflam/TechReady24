# Install dependencies for this solution

install_package <- function(name) {
    if (!(name %in% rownames(installed.packages()))) {
        install.packages(name)
    }
}

install_package('shiny')
install_package('leaflet')
install_package('dplyr')
install_package("rmarkdown")
install_package("DT")
install_package("ggmap")