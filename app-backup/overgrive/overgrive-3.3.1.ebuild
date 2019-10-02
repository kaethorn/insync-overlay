# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm gnome2-utils

DESCRIPTION="A complete Google Drive™ desktop client solution for Linux"
HOMEPAGE="https://www.thefanclub.co.za/overgrive"

SRC_URI="https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive-${PV}.noarch.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/google-api-python-client"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${P}-desktop-file-fix.patch"
)

src_unpack() {
	rpm_src_unpack
	mkdir -p "${S}"
	mv "${WORKDIR}"/{usr,opt} "${S}"/
}

src_install() {
	cp -pPR "${WORKDIR}"/"${P}"/{usr,opt} "${D}"/ || die "Installation failed"

	# Choose cpython interpreter for overgrive and copy correct compiled version and remove folder
	if [ -d "${D}"/opt/thefanclub/overgrive/__pycache__ ]
	then
		cp "${D}"/opt/thefanclub/overgrive/__pycache__/$(ls "${D}"/opt/thefanclub/overgrive/__pycache__ |  grep $(python3 -V | cut -d' ' -f2 | cut -d'.' -f1-2 | sed 's/\.//g')) "${D}"/opt/thefanclub/overgrive/overgrive
		rm -R "${D}"/opt/thefanclub/overgrive/__pycache__
	fi

	# Unpack docs
	gunzip "${D}"/usr/share/doc/overgrive/changelog.gz
	mv "${D}"/usr/share/doc/overgrive "${D}"/usr/share/doc/"${P}"
}

pkg_postinst() {
	gnome2_schemas_update
}
