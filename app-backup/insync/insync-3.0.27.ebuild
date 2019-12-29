# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm xdg-utils

DESCRIPTION="Advanced cross-platform Google Drive client"
HOMEPAGE="https://www.insynchq.com/"

MAGIC="40677"
MAIN_INSTALLER_STRING="http://s.insynchq.com/builds/insync-${PV}.${MAGIC}-fc30"

SRC_URI="
	amd64?    ( ${MAIN_INSTALLER_STRING}.x86_64.rpm )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${P}-fix-ca-path.patch"
)

src_unpack() {
	rpm_src_unpack
	mkdir -p "${S}"
	mv "${WORKDIR}"/usr "${S}"/
}

src_install() {
	cp -pPR "${WORKDIR}"/"${P}"/usr "${D}"/ || die "Installation failed"
	gunzip "${D}"/usr/share/man/man1/insync.1.gz

	echo "SEARCH_DIRS_MASK=\"/usr/lib*/insync\"" > "${T}/70-${PN}" || die
	insinto "/etc/revdep-rebuild" && doins "${T}/70-${PN}" || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
