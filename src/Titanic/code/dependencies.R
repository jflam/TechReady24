
# Run this script to install all dependencies

install_package <- function(name) {
    if (!(name %in% rownames(installed.packages()))) {
        install.packages(name)
    }
}

install_package("dplyr")
install_package("rpart")
install_package("caret")
install_package("rattle")
install_package("rpart.plot")
install_package("RColorBrewer")
install_package("Amelia")
install_package("e1071")