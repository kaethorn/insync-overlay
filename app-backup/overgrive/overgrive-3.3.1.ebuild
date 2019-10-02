# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit rpm

DESCRIPTION="A complete Google Drive™ desktop client solution for Linux"
HOMEPAGE="https://www.thefanclub.co.za/overgrive"

SRC_URI="https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive-${PV}.noarch.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	rpm_src_unpack ${A}
	mkdir -p "${S}" # Without this src_prepare fails
}

src_install() {
	cp -pPR "${WORKDIR}"/{usr,opt} "${D}"/ || die "Installation failed"

	echo "SEARCH_DIRS_MASK=\"/opt/thefanclu\"" > "${T}/70${PN}" || die
	insinto "/etc/revdep-rebuild" && doins "${T}/70${PN}" || die
}
