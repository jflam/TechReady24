install_if_not_present <- function(name) {
    if (!(name %in% rownames(installed.packages()))) {
        install.packages(name)
    }
}

install_if_not_present("ggmap")
install_if_not_present("magrittr")
install_if_not_present("mapproj")
install_if_not_present("RODBC")
install_if_not_present("ROCR")
