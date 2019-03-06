{ stdenv, fetchurl, perlPackages }:
perlPackages.buildPerlPackage rec {
  name = "shelldap-${version}";
  version = "1.4.0";
  src = fetchurl {
    url = "https://bitbucket.org/mahlon/shelldap/downloads/shelldap-${version}.tar.gz";
    sha256 = "07gkvvxcgw3pgkfy8p9mmidakciaq1rsq5zhmdqd8zcwgqkrr24i";
  };
  buildInputs = with perlPackages; [ perl YAMLSyck NetLDAP AlgorithmDiff IOSocketSSL AuthenSASL TermReadLineGnu TermShell ];
  prePatch = ''
    touch Makefile.PL
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp shelldap $out/bin
  '';
  outputs = [ "out" ];
  meta = with stdenv.lib; {
    homepage = https://bitbucket.org/mahlon/shelldap/;
    description = "A handy shell-like interface for browsing LDAP servers and editing their content";
    license = with stdenv.lib.licenses; [ bsd3 ];
    maintainers = with maintainers; [ tobiasBora ];
  };
}
