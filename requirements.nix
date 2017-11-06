# generated using pypi2nix tool (version: 1.8.1)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -E libxslt libxml2 zlib pkgconfig zlib libjpeg openjpeg libtiff freetype lcms2 libwebp tcl -v -V 2.7 -b buildout.cfg -I nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python27Full;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = old.patchPhase + ''
            sed -i               -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"                -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"                  $out/${pkgs.python35.sitePackages}/pip/req/req_install.py
          '';
        });
      };
  };

  commonBuildInputs = with pkgs; [ libxslt libxml2 zlib pkgconfig zlib libjpeg openjpeg libtiff freetype lcms2 libwebp tcl ];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python27Full-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter}               $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "               (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable}               python2
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };
    in {
      __old = pythonPackages;
      inherit interpreter;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (drv.drvAttrs // f drv.drvAttrs //                                            { meta = drv.meta; });
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {

    "AccessControl" = python.mkDerivation {
      name = "AccessControl-3.0.13";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/0b/3d/41ee94d598c70c43af5e9df3da9a98e78d0d0e5ac55f9d67f4c44edee67f/AccessControl-3.0.13.tar.gz"; sha256 = "c57e38354562a36680bd58e0e2653c2989b415164184d31c99e55fbbdc6b238d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."ExtensionClass"
      self."Persistence"
      self."Record"
      self."RestrictedPython"
      self."ZODB3"
      self."transaction"
      self."zExceptions"
      self."zope.component"
      self."zope.configuration"
      self."zope.deferredimport"
      self."zope.interface"
      self."zope.publisher"
      self."zope.schema"
      self."zope.security"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/AccessControl";
        license = licenses.zpl21;
        description = "Security framework for Zope2.";
      };
    };



    "Acquisition" = python.mkDerivation {
      name = "Acquisition-4.2.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/9e/32/00f343af778abd9f260fe3b8b183fc5033eb554c65d5c7c601dfcd848536/Acquisition-4.2.2.tar.gz"; sha256 = "90bbeedfff34630d63adf97be5c156ad28920412b319eb95db7d6d39de7bd623"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ExtensionClass"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zopefoundation/Acquisition";
        license = licenses.zpl21;
        description = "Acquisition is a mechanism that allows objects to obtain attributes from the containment hierarchy they're in.";
      };
    };



    "Babel" = python.mkDerivation {
      name = "Babel-1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/33/27/e3978243a03a76398c384c83f7ca879bc6e8f1511233a621fcada135606e/Babel-1.3.tar.gz"; sha256 = "9f02d0357184de1f093c10012b52e7454a1008be6a5c185ab7a3307aceb1d12e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytz"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://babel.pocoo.org/";
        license = licenses.bsdOriginal;
        description = "Internationalization utilities";
      };
    };



    "Chameleon" = python.mkDerivation {
      name = "Chameleon-2.25";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/bc/98/373f98967203f581f7675a29cf0c823e7454b047f5795b42615caccb46f6/Chameleon-2.25.tar.gz"; sha256 = "6b2740e077626306c10a659bb9fe80d2eb8b6ceb89b521dfbed2f1432b2b496d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/malthe/chameleon";
        license = "BSD-like (http://repoze.org/license.html)";
        description = "Fast HTML/XML Template Compiler.";
      };
    };



    "DateTime" = python.mkDerivation {
      name = "DateTime-4.0.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/66/3c/cf4272421dc2c2094563093dcc57930b589f54c84f2fa5eaf27442cc4c35/DateTime-4.0.1.zip"; sha256 = "a4073f0549862278aad3986982e835092009fca681f9d4a719112eb24964695b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytz"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "";
        description = "This package provides a DateTime data type, as known from Zope 2.";
      };
    };



    "DocumentTemplate" = python.mkDerivation {
      name = "DocumentTemplate-2.13.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/af/d3/14e5a48d4c3c49718a700320290d16fe6727b4756d1fdfbc9841190f0678/DocumentTemplate-2.13.4.tar.gz"; sha256 = "a96be48a48f11ce069c4ace702880bee155567de964c63d71170a12af2d5fc5d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."AccessControl"
      self."Acquisition"
      self."ExtensionClass"
      self."RestrictedPython"
      self."zExceptions"
      self."zope.sequencesort"
      self."zope.structuredtext"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/DocumentTemplate";
        license = licenses.zpl21;
        description = "Document Templating Markup Language (DTML)";
      };
    };



    "ExtensionClass" = python.mkDerivation {
      name = "ExtensionClass-4.1.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/87/17/9568f8c251885a3d359b253f1959f5bd9f041eaf66db4370cb8e5ea0c9f2/ExtensionClass-4.1.2.tar.gz"; sha256 = "eaa5e0f37a8303e2d4a08f74d8dfadd34c9de0de789f6934590923d03b670199"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/ExtensionClass";
        license = licenses.zpl21;
        description = "Metaclass for subclassable extension types";
      };
    };



    "Markdown" = python.mkDerivation {
      name = "Markdown-2.6.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/9b/53/4492f2888408a2462fd7f364028b6c708f3ecaa52a028587d7dd729f40b4/Markdown-2.6.6.tar.gz"; sha256 = "9a292bb40d6d29abac8024887bcfc1159d7a32dc1d6f1f6e8d6d8e293666c504"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pythonhosted.org/Markdown/";
        license = licenses.bsdOriginal;
        description = "Python implementation of Markdown.";
      };
    };



    "Missing" = python.mkDerivation {
      name = "Missing-2.13.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/54/30/f37047f6ce32ace5be65a34db074c0757eefc304f507798a858690e46e6d/Missing-2.13.1.zip"; sha256 = "475f2751779cd9f9268073a3eb6fd2ceda7f45e595631c0988ae33db86821a0f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ExtensionClass"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Missing";
        license = licenses.zpl21;
        description = "Special Missing objects used in Zope2.";
      };
    };



    "MultiMapping" = python.mkDerivation {
      name = "MultiMapping-2.13.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f9/19/00998d8346ff71e92c6d9de24a75932e4183ad8ada59028359856cfcbbfe/MultiMapping-2.13.0.zip"; sha256 = "7bb014c10587245a8d2d90e7e39b4ae11973af44dd87c55436e09630af3ec661"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ExtensionClass"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/MultiMapping";
        license = licenses.zpl21;
        description = "Special MultiMapping objects used in Zope2.";
      };
    };



    "Persistence" = python.mkDerivation {
      name = "Persistence-2.13.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c1/f8/39c50b4d91f0aa0d28423159c6d16751b63de758a4e5358e98140ff987e7/Persistence-2.13.2.zip"; sha256 = "5a4500317a2c390609b20763b6e8e2e960df47d87adce98466e290e974fe2397"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ExtensionClass"
      self."ZODB3"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Persistence";
        license = licenses.zpl21;
        description = "Persistent ExtensionClass";
      };
    };



    "Pillow" = python.mkDerivation {
      name = "Pillow-4.3.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e0/82/ec499c78bfe4ecaa91c2f3000040451d187ed0a816d58b8543e29c48827f/Pillow-4.3.0.tar.gz"; sha256 = "a97c715d44efd5b4aa8d739b8fad88b93ed79f1b33fc2822d5802043f3b1b527"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."olefile"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://python-pillow.org";
        license = "Standard PIL License";
        description = "Python Imaging Library (Fork)";
      };
    };



    "Plone" = python.mkDerivation {
      name = "Plone-5.0.8";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/47/d2/850d7f51cc273a8558d2439d632120d279aba6c5e86aee18aa1ff9b98ab8/Plone-5.0.8.tar.gz"; sha256 = "b5b43bec3054d3f2854bd89700a19f603631e012ae7d42e596a8c501eedf59cb"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.ATContentTypes"
      self."Products.Archetypes"
      self."Products.CMFPlacefulWorkflow"
      self."Products.CMFPlone"
      self."archetypes.multilingual"
      self."plone.app.caching"
      self."plone.app.dexterity"
      self."plone.app.iterate"
      self."plone.app.openid"
      self."plone.app.upgrade"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://plone.org/";
        license = licenses.gpl1;
        description = "The Plone Content Management System";
      };
    };



    "Products.ATContentTypes" = python.mkDerivation {
      name = "Products.ATContentTypes-2.2.13";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/9e/4b/c2da805e134eb865bf469457fd442c4efb5f9c8aa7d653eccc3ca0553a2a/Products.ATContentTypes-2.2.13.tar.gz"; sha256 = "cf4eab79fd1a7302774843f9a1d738ed4b56383ec939a840cdcb78b12fa95a2b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."ExtensionClass"
      self."Products.Archetypes"
      self."Products.CMFCore"
      self."Products.CMFDynamicViewFTI"
      self."Products.CMFFormController"
      self."Products.CMFPlone"
      self."Products.GenericSetup"
      self."Products.MimetypesRegistry"
      self."Products.PortalTransforms"
      self."Products.validation"
      self."ZConfig"
      self."ZODB3"
      self."Zope2"
      self."plone.app.blob"
      self."plone.app.collection"
      self."plone.app.folder"
      self."plone.app.layout"
      self."plone.app.testing"
      self."plone.app.widgets"
      self."plone.i18n"
      self."plone.memoize"
      self."transaction"
      self."zope.annotation"
      self."zope.component"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.publisher"
      self."zope.tal"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://plone.org/";
        license = "GPL";
        description = "Default Content Types for Plone 2.1-4.3";
      };
    };



    "Products.Archetypes" = python.mkDerivation {
      name = "Products.Archetypes-1.10.18";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/db/28/fb626c4e66566d32ba0b7f928d02e5e8b773a0813f0bdc07cebff82c6213/Products.Archetypes-1.10.18.tar.gz"; sha256 = "2f58884195af06cd9574d27c4a68846624ebd80aa9157a19744ddd17eff65040"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."ExtensionClass"
      self."Plone"
      self."Products.CMFCore"
      self."Products.CMFFormController"
      self."Products.CMFQuickInstallerTool"
      self."Products.DCWorkflow"
      self."Products.GenericSetup"
      self."Products.MimetypesRegistry"
      self."Products.PlacelessTranslationService"
      self."Products.PortalTransforms"
      self."Products.ZSQLMethods"
      self."Products.statusmessages"
      self."Products.validation"
      self."ZODB3"
      self."Zope2"
      self."plone.app.folder"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.app.widgets"
      self."plone.folder"
      self."plone.uuid"
      self."transaction"
      self."zope.annotation"
      self."zope.component"
      self."zope.contenttype"
      self."zope.datetime"
      self."zope.deferredimport"
      self."zope.event"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.publisher"
      self."zope.schema"
      self."zope.tal"
      self."zope.testing"
      self."zope.viewlet"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.Archetypes";
        license = "GPL";
        description = "Archetypes is a developers framework for rapidly developing and deploying rich, full featured content types within the context of Zope/CMF and Plone.";
      };
    };



    "Products.BTreeFolder2" = python.mkDerivation {
      name = "Products.BTreeFolder2-2.14.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c4/dd/5da8431249f2e72bd31b500ec73b91aeca4b342afd44cba9094026d98e1b/Products.BTreeFolder2-2.14.0.tar.gz"; sha256 = "d234839b43d4c9869c19daef0b9882a97b77e789c0557f7a0b7998607f037b5d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."AccessControl"
      self."Acquisition"
      self."ExtensionClass"
      self."Persistence"
      self."ZODB3"
      self."Zope2"
      self."zope.container"
      self."zope.event"
      self."zope.lifecycleevent"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.BTreeFolder2";
        license = licenses.zpl21;
        description = "A BTree based implementation for Zope 2's OFS.";
      };
    };



    "Products.CMFCore" = python.mkDerivation {
      name = "Products.CMFCore-2.2.10";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/83/93/7340ae9f6546cf363ca0db84da7db6bfe9fcb525f13380377fbbdd47e113/Products.CMFCore-2.2.10.tar.gz"; sha256 = "3a24de464945f35d142e4659c62da887a19522e53cb74209f1554433b31e5560"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.GenericSetup"
      self."Products.ZSQLMethods"
      self."Zope2"
      self."five.localsitemanager"
      self."zope.app.publication"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.CMFCore";
        license = licenses.zpl21;
        description = "Zope Content Management Framework core components";
      };
    };



    "Products.CMFDiffTool" = python.mkDerivation {
      name = "Products.CMFDiffTool-3.1.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/29/d9/ad1f4513fe5968572ae7e58b2a358d2d2b260404a688632071c1d03177a7/Products.CMFDiffTool-3.1.4.tar.gz"; sha256 = "e41ab29f080dadf409173d1ee662e025fc7917764c072c07465dc33477a8b9da"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFCore"
      self."Products.GenericSetup"
      self."Zope2"
      self."plone.app.contenttypes"
      self."plone.app.dexterity"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.namedfile"
      self."zope.component"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.CMFDiffTool";
        license = "GPL";
        description = "Diff tool for Plone";
      };
    };



    "Products.CMFDynamicViewFTI" = python.mkDerivation {
      name = "Products.CMFDynamicViewFTI-4.1.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f1/46/b30a0a317fcbb25bc1e85cebca9e4dc82d3a48b6c383a00366ee9645a7fc/Products.CMFDynamicViewFTI-4.1.5.tar.gz"; sha256 = "4a60c3874ff165c7325b0197adb39c80e12309b94a583ef60578852cff235f4e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."ExtensionClass"
      self."Products.Archetypes"
      self."Products.CMFCore"
      self."Products.GenericSetup"
      self."Zope2"
      self."plone.app.contentmenu"
      self."plone.app.testing"
      self."zope.browsermenu"
      self."zope.component"
      self."zope.interface"
      self."zope.publisher"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.CMFDynamicViewFTI";
        license = "ZPL";
        description = "CMFDynamicViewFTI is a product for dynamic views in CMF.";
      };
    };



    "Products.CMFEditions" = python.mkDerivation {
      name = "Products.CMFEditions-2.2.23";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/bc/62/b13e18b1a5552972863cc8c90f0daab8e9faff49294babf45484b5edbbda/Products.CMFEditions-2.2.23.tar.gz"; sha256 = "0b32c02ac23bae2c7df524720d8413abc9ca86b22c44f0086b9f74947b08a3ee"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."Products.Archetypes"
      self."Products.CMFCore"
      self."Products.CMFDiffTool"
      self."Products.CMFDynamicViewFTI"
      self."Products.CMFPlone"
      self."Products.CMFUid"
      self."Products.GenericSetup"
      self."Products.ZopeVersionControl"
      self."ZODB3"
      self."Zope2"
      self."plone.app.testing"
      self."transaction"
      self."zope.copy"
      self."zope.dottedname"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.CMFEditions";
        license = "GPL";
        description = "Versioning for Plone";
      };
    };



    "Products.CMFFormController" = python.mkDerivation {
      name = "Products.CMFFormController-3.0.8";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/91/df/8b9d982834aacc7643a3a5737451881f1298c1d43bf3761685b63f56f927/Products.CMFFormController-3.0.8.tar.gz"; sha256 = "2170f193217e5972741ed8278217fd5d27a19c168511c3392f7e12c1dcff875b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFCore"
      self."Products.GenericSetup"
      self."Zope2"
      self."plone.app.testing"
      self."transaction"
      self."zope.interface"
      self."zope.structuredtext"
      self."zope.tales"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.CMFFormController";
        license = licenses.bsdOriginal;
        description = "CMFFormController provides a form validation mechanism for CMF.";
      };
    };



    "Products.CMFPlacefulWorkflow" = python.mkDerivation {
      name = "Products.CMFPlacefulWorkflow-1.6.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/86/66/4b48a73bd5dacf58e7d8365daf9368ecfc159644e0b69a40c666955ebf66/Products.CMFPlacefulWorkflow-1.6.7.tar.gz"; sha256 = "e6c9ac1ec04c8de5c6aa0143e7859d32600e1f88a4fe2830a9f817bb653a3d3c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Products.GenericSetup"
      self."plone.app.testing"
      self."zope.component"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.CMFPlacefulWorkflow";
        license = "GPL";
        description = "Workflow policies for Plone";
      };
    };



    "Products.CMFPlone" = python.mkDerivation {
      name = "Products.CMFPlone-5.0.8";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/22/b8/240bfef059056ef6d5b9e2caeef6cc20eae6c9636b8c9d969d923a49691e/Products.CMFPlone-5.0.8.tar.gz"; sha256 = "22bd71a2c51685975af30cdc5f9207a3be82b98e8192df4831105aa8b8035b05"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."ExtensionClass"
      self."Pillow"
      self."Products.ATContentTypes"
      self."Products.CMFCore"
      self."Products.CMFDiffTool"
      self."Products.CMFDynamicViewFTI"
      self."Products.CMFEditions"
      self."Products.CMFQuickInstallerTool"
      self."Products.CMFUid"
      self."Products.DCWorkflow"
      self."Products.ExtendedPathIndex"
      self."Products.ExternalEditor"
      self."Products.GenericSetup"
      self."Products.MimetypesRegistry"
      self."Products.PasswordResetTool"
      self."Products.PlacelessTranslationService"
      self."Products.PlonePAS"
      self."Products.PluggableAuthService"
      self."Products.PluginRegistry"
      self."Products.PortalTransforms"
      self."Products.ResourceRegistries"
      self."Products.contentmigration"
      self."Products.statusmessages"
      self."ZODB3"
      self."Zope2"
      self."borg.localrole"
      self."cssmin"
      self."five.customerize"
      self."five.localsitemanager"
      self."five.pt"
      self."lxml"
      self."mockup"
      self."plone.api"
      self."plone.app.content"
      self."plone.app.contentlisting"
      self."plone.app.contentmenu"
      self."plone.app.contentrules"
      self."plone.app.contenttypes"
      self."plone.app.controlpanel"
      self."plone.app.customerize"
      self."plone.app.dexterity"
      self."plone.app.discussion"
      self."plone.app.folder"
      self."plone.app.i18n"
      self."plone.app.layout"
      self."plone.app.linkintegrity"
      self."plone.app.locales"
      self."plone.app.multilingual"
      self."plone.app.portlets"
      self."plone.app.redirector"
      self."plone.app.registry"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.app.theming"
      self."plone.app.users"
      self."plone.app.uuid"
      self."plone.app.viewletmanager"
      self."plone.app.vocabularies"
      self."plone.app.workflow"
      self."plone.batching"
      self."plone.browserlayer"
      self."plone.contentrules"
      self."plone.i18n"
      self."plone.indexer"
      self."plone.intelligenttext"
      self."plone.locking"
      self."plone.memoize"
      self."plone.outputfilters"
      self."plone.portlet.collection"
      self."plone.portlet.static"
      self."plone.portlets"
      self."plone.protect"
      self."plone.registry"
      self."plone.schema"
      self."plone.session"
      self."plone.theme"
      self."plonetheme.barceloneta"
      self."slimit"
      self."transaction"
      self."z3c.autoinclude"
      self."zope.app.locales"
      self."zope.cachedescriptors"
      self."zope.component"
      self."zope.container"
      self."zope.deferredimport"
      self."zope.deprecation"
      self."zope.dottedname"
      self."zope.event"
      self."zope.globalrequest"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.location"
      self."zope.pagetemplate"
      self."zope.publisher"
      self."zope.site"
      self."zope.structuredtext"
      self."zope.tal"
      self."zope.tales"
      self."zope.testing"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://plone.org/";
        license = licenses.gpl1;
        description = "The Plone Content Management System (core)";
      };
    };



    "Products.CMFQuickInstallerTool" = python.mkDerivation {
      name = "Products.CMFQuickInstallerTool-3.0.15";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/82/31/b3e6447b46c266b3aaf6c0a395c51019ba009d76795c949eb4b1141c9dcc/Products.CMFQuickInstallerTool-3.0.15.tar.gz"; sha256 = "32e0cc0871c115dd341e68dba2b4a9a73c714e9f74cb41f2e08b8a097612b51b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."Products.CMFCore"
      self."Products.GenericSetup"
      self."Zope2"
      self."plone.app.testing"
      self."plone.protect"
      self."zope.annotation"
      self."zope.component"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.CMFQuickInstallerTool";
        license = licenses.gpl1;
        description = "A facility for comfortable activation/deactivation of CMF compliant add ons for Zope.";
      };
    };



    "Products.CMFUid" = python.mkDerivation {
      name = "Products.CMFUid-2.2.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/49/57/6ae13135a875d53376ceed1a803406f6bac922c8d697b885705e5fd0c42d/Products.CMFUid-2.2.2.tar.gz"; sha256 = "f43723f0a38ec22e080504ad90ce015ea5ce1d585865d3d12748cd3ca06fcca0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."Products.GenericSetup"
      self."Zope2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.CMFUid";
        license = licenses.zpl21;
        description = "Uid product for the Zope Content Management Framework";
      };
    };



    "Products.DCWorkflow" = python.mkDerivation {
      name = "Products.DCWorkflow-2.2.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/96/7b/e61ea9587eb30b08a66dc8cc9d946a47e7eb036cead872a62f53ad386b3e/Products.DCWorkflow-2.2.5.tar.gz"; sha256 = "ed305a0f54f1e9f6852a69d589faa893b953dc8345e32238b82f1db3cccac26f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."Products.GenericSetup"
      self."Zope2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.DCWorkflow";
        license = licenses.zpl21;
        description = "DCWorkflow product for the Zope Content Management Framework";
      };
    };



    "Products.DateRecurringIndex" = python.mkDerivation {
      name = "Products.DateRecurringIndex-2.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/cf/18/4959bf3e72720e107998975f2c14f61de9f035388557ffd756154f0d6f0e/Products.DateRecurringIndex-2.1.zip"; sha256 = "b9a5ab576c45c7ad95db1951fb8e56537707ebe82bbe32899ce2d28a61ef180c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."Zope2"
      self."plone.event"
      self."plone.testing"
      self."pytz"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/collective/Products.DateRecurringIndex";
        license = licenses.bsdOriginal;
        description = "Zope 2 date index with support for recurring events.";
      };
    };



    "Products.ExtendedPathIndex" = python.mkDerivation {
      name = "Products.ExtendedPathIndex-3.1.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8e/b2/93f3cad9729f22a6d7c3471d5ea58c38c4e0bfe98778aa763b554f462ce6/Products.ExtendedPathIndex-3.1.1.tar.gz"; sha256 = "8de7c8c6dd19f47d0cc2456db18464268cbfe0ec185dd1b37d631f2f74e0a1c4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."AccessControl"
      self."ZODB3"
      self."Zope2"
      self."transaction"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.ExtendedPathIndex";
        license = licenses.gpl1;
        description = "Zope catalog index for paths";
      };
    };



    "Products.ExternalEditor" = python.mkDerivation {
      name = "Products.ExternalEditor-1.1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a6/0f/ef11be27b0e5227e6fdead334fd0c37c361382769d630b34d6519b285cde/Products.ExternalEditor-1.1.3.tar.gz"; sha256 = "860d1a223641b2218a01b3018324175bdd6952f31a7e795c447fb6d0b358f450"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.ExternalEditor";
        license = licenses.zpl21;
        description = "Zope External Editor";
      };
    };



    "Products.ExternalMethod" = python.mkDerivation {
      name = "Products.ExternalMethod-2.13.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4c/4a/a8160b0e4ae6678aec02bc1b5d4db8a7b0265dd012a1cbe527a4460a17c9/Products.ExternalMethod-2.13.1.zip"; sha256 = "0caabb212fe8730b5e5f089f687d42a0f5a9997abcd11bf300b934e91b53dc6d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."AccessControl"
      self."Acquisition"
      self."ExtensionClass"
      self."Persistence"
      self."ZODB3"
      self."Zope2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.ExternalMethod";
        license = licenses.zpl21;
        description = "This package provides support for external Python methods within a Zope 2 environment.";
      };
    };



    "Products.GenericSetup" = python.mkDerivation {
      name = "Products.GenericSetup-1.8.8";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/10/56/11b8e227c8aa523e1c3ee3495fa6f60e816ce9ae1295743e44ed16afa958/Products.GenericSetup-1.8.8.tar.gz"; sha256 = "3c9e5c127c6f9e601a61c4ad9e21ccb4b2521024216506befa3866c12dad3c06"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
      self."five.localsitemanager"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.GenericSetup";
        license = licenses.zpl21;
        description = "Read Zope configuration state from profile dirs / tarballs";
      };
    };



    "Products.MIMETools" = python.mkDerivation {
      name = "Products.MIMETools-2.13.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/30/53/9e08e6a2f5e1c12b1d450c78025a54edbd70e40a15191de9e81839bad53a/Products.MIMETools-2.13.0.zip"; sha256 = "bb0f1384235813372b6a2e5ddcf60ac2dfd8903a7d5241a79d388dcfafca5bb7"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."DocumentTemplate"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.MIMETools";
        license = licenses.zpl21;
        description = "MIMETools provides the &lt;!--#mime--&gt; tag for DocumentTemplate.";
      };
    };



    "Products.MailHost" = python.mkDerivation {
      name = "Products.MailHost-2.13.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fa/38/96b5f69c9fa11bc322b641b6517d51434d3b7573426ce1d9621fadc98a05/Products.MailHost-2.13.2.zip"; sha256 = "5ccd20d7cd7979a7cc4c1db04fafe542f29e1c2cde18f6289a5d0a342e843e3a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."AccessControl"
      self."Acquisition"
      self."DateTime"
      self."DocumentTemplate"
      self."Persistence"
      self."Zope2"
      self."zope.deferredimport"
      self."zope.interface"
      self."zope.sendmail"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.MailHost";
        license = licenses.zpl21;
        description = "zope.sendmail integration for Zope 2.";
      };
    };



    "Products.MimetypesRegistry" = python.mkDerivation {
      name = "Products.MimetypesRegistry-2.0.10";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/37/cf/96a0138a124d0b08833eb90ba447d7a10c23cad7897580b624ff86b2a486/Products.MimetypesRegistry-2.0.10.tar.gz"; sha256 = "430e0128b04d9e8655527bb34aba8a1777d819f0c796a325d23fcd4f0884a3fb"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFCore"
      self."ZODB3"
      self."Zope2"
      self."plone.app.testing"
      self."zope.contenttype"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.MimetypesRegistry";
        license = licenses.gpl1;
        description = "MIME type handling for Zope";
      };
    };



    "Products.OFSP" = python.mkDerivation {
      name = "Products.OFSP-2.13.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c9/a7/d9044a5fde407aaa8992f596962d325a6950d1f1e999d52d9914eca419d9/Products.OFSP-2.13.2.zip"; sha256 = "a3a831a0ff7b5befd722141de02bebe6fd63f961569b6b7504a99ca3515f357c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."AccessControl"
      self."Persistence"
      self."Zope2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.OFSP";
        license = licenses.zpl21;
        description = "General Zope 2 help screens.";
      };
    };



    "Products.PasswordResetTool" = python.mkDerivation {
      name = "Products.PasswordResetTool-2.2.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/02/02/1025af9ff7efc51908ea3919bb19e9c4560b675e8f3a417ef44a75d18449/Products.PasswordResetTool-2.2.3.tar.gz"; sha256 = "764e78acdebe2b53d10c156554bc8b1c197a74de2ac388eb1a4ada4ddcbdb31b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Zope2"
      self."plone.app.registry"
      self."plone.app.testing"
      self."plone.memoize"
      self."zope.component"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.PasswordResetTool";
        license = licenses.gpl1;
        description = "Password reset tool for Plone";
      };
    };



    "Products.PlacelessTranslationService" = python.mkDerivation {
      name = "Products.PlacelessTranslationService-2.0.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/20/40/b1e4ab971e489c074c3f3c4095f08278b7db5f1fd1c0d8d06cad1b3f6ab1/Products.PlacelessTranslationService-2.0.7.tar.gz"; sha256 = "226a105b97ee586fe14a0c0193bc38c12ef9464c96c8dda63e6569687fcc5e1c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."ExtensionClass"
      self."ZODB3"
      self."Zope2"
      self."python-gettext"
      self."zope.annotation"
      self."zope.component"
      self."zope.deferredimport"
      self."zope.deprecation"
      self."zope.i18n"
      self."zope.interface"
      self."zope.publisher"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.PlacelessTranslationService";
        license = licenses.gpl1;
        description = "PTS provides a way of internationalizing (i18n'ing) and localizing (l10n'ing) software for Zope 2.";
      };
    };



    "Products.PlonePAS" = python.mkDerivation {
      name = "Products.PlonePAS-5.0.14";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/df/2d/03fa3c4240e6dff6490c80baf1c63830a383bac554e65b59437db3a2f015/Products.PlonePAS-5.0.14.tar.gz"; sha256 = "982bcc361f135a35c9e953b30eaabf83f04b68c765a6a9fc003fa264c87d007a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."Products.GenericSetup"
      self."Products.PluggableAuthService"
      self."Zope2"
      self."plone.app.testing"
      self."plone.i18n"
      self."plone.memoize"
      self."plone.protect"
      self."plone.session"
      self."plone.testing"
      self."zope.deprecation"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.PlonePAS";
        license = "ZPL";
        description = "PlonePAS modifies the PluggableAuthService for use by Plone.";
      };
    };



    "Products.PluggableAuthService" = python.mkDerivation {
      name = "Products.PluggableAuthService-1.11.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/cf/6a/57d824ba9ac9448186d97644b5040e86b753b8d0d5b9e9f222285fc94190/Products.PluggableAuthService-1.11.0.tar.gz"; sha256 = "53e2e79bd4b9c3ce87fde50fbc14f3159256f3f91e423157031a2833d2905fa0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.GenericSetup"
      self."Products.PluginRegistry"
      self."Zope2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.PluggableAuthService";
        license = licenses.zpl21;
        description = "Pluggable Zope2 authentication / authorization framework";
      };
    };



    "Products.PluginRegistry" = python.mkDerivation {
      name = "Products.PluginRegistry-1.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/7c/01/9af56277897e0c3f2fd745a9dfe0ef3b1ce13e5d487aac9049c99645e0e7/Products.PluginRegistry-1.4.tar.gz"; sha256 = "d9a9c67b0e4cb4322e54bbdda7e4419bd4d283d1b5174737e919e48a025bb017"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.GenericSetup"
      self."Zope2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.PluginRegistry";
        license = licenses.zpl21;
        description = "Configure application plugins based on interfaces";
      };
    };



    "Products.PortalTransforms" = python.mkDerivation {
      name = "Products.PortalTransforms-2.2.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/2d/4a/ba3bd4ae152a787ab33137626d24096ccac1d9aeaab0b853281e753dc8b7/Products.PortalTransforms-2.2.1.tar.gz"; sha256 = "a0ea886bd7daf14e854e92105f0466738a6b6d007cf513b2a88c1408781e0c71"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Markdown"
      self."Pillow"
      self."Products.Archetypes"
      self."Products.CMFCore"
      self."Products.MimetypesRegistry"
      self."ZODB3"
      self."Zope2"
      self."plone.intelligenttext"
      self."zope.interface"
      self."zope.structuredtext"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.PortalTransforms";
        license = "";
        description = "MIME based content transformations";
      };
    };



    "Products.PythonScripts" = python.mkDerivation {
      name = "Products.PythonScripts-2.13.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/69/10/354788f825c17a015d189ce0e9c365934383f779b95ad585c170f7becdf8/Products.PythonScripts-2.13.2.zip"; sha256 = "c1ae5a73850a7fce5bfa4c1abd598149e9c6dc1f81271b002e4dc6f8fce595b5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."AccessControl"
      self."Acquisition"
      self."DateTime"
      self."DocumentTemplate"
      self."RestrictedPython"
      self."Zope2"
      self."zExceptions"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.PythonScripts";
        license = licenses.zpl21;
        description = "Provides support for restricted execution of Python scripts in Zope 2.";
      };
    };



    "Products.ResourceRegistries" = python.mkDerivation {
      name = "Products.ResourceRegistries-3.0.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/51/1d/95204a13069a66eb2e3beb1a6665954162cb51a511a2e180121b253beeb1/Products.ResourceRegistries-3.0.5.tar.gz"; sha256 = "ab78ce51082501953bd3de767aa77c591f793237b404e6237e35c26826135935"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."Products.CMFCore"
      self."Products.GenericSetup"
      self."ZODB3"
      self."Zope2"
      self."plone.app.registry"
      self."plone.protect"
      self."zope.component"
      self."zope.contentprovider"
      self."zope.interface"
      self."zope.viewlet"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.ResourceRegistries";
        license = licenses.gpl1;
        description = "Registry for managing CSS and JS";
      };
    };



    "Products.Sessions" = python.mkDerivation {
      name = "Products.Sessions-3.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8d/9f/f3a8a1d8b2adf4320ad3a896c69aa649fa06c2fff1f9e0f397cee148c5e9/Products.Sessions-3.0.zip"; sha256 = "8a8707b203ee0cba390671f3926b35bd1ff999bf00255edd227ad0d496dd1ddf"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.Sessions";
        license = licenses.zpl21;
        description = "Zope 2 session management.";
      };
    };



    "Products.StandardCacheManagers" = python.mkDerivation {
      name = "Products.StandardCacheManagers-2.13.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/7f/a7/fb0ea5f0b3b189e7517580b6d84a5ed4ecc98bd2414bacc7c282c9bb28db/Products.StandardCacheManagers-2.13.1.tar.gz"; sha256 = "b27902493c85a08da2eba37691772d8eb9f04081c9b31bd3ab60d45834651dbd"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."AccessControl"
      self."Zope2"
      self."transaction"
      self."zope.component"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.StandardCacheManagers";
        license = licenses.zpl21;
        description = "Cache managers for Zope 2.";
      };
    };



    "Products.TemporaryFolder" = python.mkDerivation {
      name = "Products.TemporaryFolder-3.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1c/16/28240ce5cb7de9a3e7d6331a6f1d23ab812e3aef1423e65a6ccd90ee7451/Products.TemporaryFolder-3.0.zip"; sha256 = "f92986e90f71ce99834469700cd8ae70b0f640d76176d36aeaffca5abd9a9b3b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.TemporaryFolder";
        license = licenses.zpl21;
        description = "Zope 2 temporary folder support.";
      };
    };



    "Products.ZCTextIndex" = python.mkDerivation {
      name = "Products.ZCTextIndex-2.13.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/34/6c/860664bdc23dc65362537b7b06f6113dcb062129e840ccab97bf11c87e4b/Products.ZCTextIndex-2.13.5.zip"; sha256 = "a431189e405ad927a1a10b1d230534f824d6be62a99b666a0747e7b1c1c28dfe"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."AccessControl"
      self."Acquisition"
      self."Persistence"
      self."ZODB3"
      self."Zope2"
      self."transaction"
      self."zExceptions"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.ZCTextIndex";
        license = licenses.zpl21;
        description = "Full text indexing for ZCatalog / Zope 2.";
      };
    };



    "Products.ZCatalog" = python.mkDerivation {
      name = "Products.ZCatalog-3.0.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4d/d2/bf4f765265818c4ec3f59247c823b6ba10a654ed802498408e9ea38e14eb/Products.ZCatalog-3.0.2.zip"; sha256 = "09bf7381e041e7f21e0e50e3665cd73ee65ae9d6a769087f114b11dc326cc4e9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."AccessControl"
      self."Acquisition"
      self."DateTime"
      self."DocumentTemplate"
      self."ExtensionClass"
      self."Missing"
      self."Persistence"
      self."Products.ZCTextIndex"
      self."Record"
      self."RestrictedPython"
      self."ZODB3"
      self."Zope2"
      self."zExceptions"
      self."zope.dottedname"
      self."zope.interface"
      self."zope.schema"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.ZCatalog";
        license = licenses.zpl21;
        description = "Zope 2's indexing and search solution.";
      };
    };



    "Products.ZSQLMethods" = python.mkDerivation {
      name = "Products.ZSQLMethods-2.13.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/95/87/0da6067e22524e9c5901085049bb2ec9a9ea510d33233007cfaf88bbc772/Products.ZSQLMethods-2.13.5.tar.gz"; sha256 = "f0010c09b0ce92a6f761ed0087eeb7f78faf33541909c4c8ad3e67b7a079115d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."ExtensionClass"
      self."Missing"
      self."Persistence"
      self."Record"
      self."ZODB3"
      self."Zope2"
      self."transaction"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.ZSQLMethods";
        license = licenses.zpl21;
        description = "SQL method support for Zope 2.";
      };
    };



    "Products.ZopeVersionControl" = python.mkDerivation {
      name = "Products.ZopeVersionControl-1.1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ad/0b/3583950d36054fce946da737d168ba84d1bc3ebd4cb8026149b8bcc5a901/Products.ZopeVersionControl-1.1.3.zip"; sha256 = "8635339be3d469400aba9ab4eff17b9dd75248a4d4a8551f7201ab61eb8ea740"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."ZODB3"
      self."Zope2"
      self."transaction"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Products.ZopeVersionControl";
        license = "ZPL";
        description = "Zope Version Control";
      };
    };



    "Products.contentmigration" = python.mkDerivation {
      name = "Products.contentmigration-2.1.16";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/39/4c/cc3e08f962ef69828a187976c7241cc332489fe334829d4ffcdd290ba124/Products.contentmigration-2.1.16.tar.gz"; sha256 = "1af9ca565023b38b06ce7680f8d5931a7c0c795dc4a50a21239b398e96ec1fa8"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFPlone"
      self."Zope2"
      self."archetypes.schemaextender"
      self."plone.app.testing"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.contentmigration";
        license = licenses.lgpl3;
        description = "A generic content migration framework for Plone.";
      };
    };



    "Products.statusmessages" = python.mkDerivation {
      name = "Products.statusmessages-4.1.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a8/b4/9981b63c61963189a07b811d8cbfc55fe489d3fae08b23ade5197d36c50f/Products.statusmessages-4.1.2.tar.gz"; sha256 = "76504eeba020cfce8ea87bc26d55d8f301288045581e8337d906c0c542f2ae42"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
      self."zope.annotation"
      self."zope.component"
      self."zope.i18n"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.statusmessages";
        license = licenses.bsdOriginal;
        description = "statusmessages provides an easy way of handling internationalized status messages managed via an BrowserRequest adapter storing status messages in client-side cookies.";
      };
    };



    "Products.validation" = python.mkDerivation {
      name = "Products.validation-2.0.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b2/af/d02b43ed51b98b89c1ac321267c4ef3a509524183ef9ee5ac25b6d169434/Products.validation-2.0.2.tar.gz"; sha256 = "31528213d58046c448fe001b298eea7c0ba7a665a697b5f68884c16a2e43ebe9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."Products.Archetypes"
      self."Zope2"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/Products.validation";
        license = "GPL";
        description = "Data validation package for Archetypes";
      };
    };



    "PyYAML" = python.mkDerivation {
      name = "PyYAML-3.12";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4a/85/db5a2df477072b2902b0eb892feb37d88ac635d36245a72a6a69b23b383a/PyYAML-3.12.tar.gz"; sha256 = "592766c6303207a20efc445587778322d7f73b161bd994f227adaa341ba212ab"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pyyaml.org/wiki/PyYAML";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };



    "Record" = python.mkDerivation {
      name = "Record-2.13.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/7b/b5/def1a908f1435084e8ebd7a674e70a61fa0962dae79345b0e6320dc0cd9f/Record-2.13.0.zip"; sha256 = "71caed8d5c09f75a7469b310b18c077625390d28e9134f4399e4d31344fdac36"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ExtensionClass"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/Record";
        license = licenses.zpl21;
        description = "Special Record objects used in Zope2.";
      };
    };



    "RestrictedPython" = python.mkDerivation {
      name = "RestrictedPython-3.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/22/f1/557f90f0881f4b2d1d343bcae31f6dfa992a364bd51f1d8ca180249e62ad/RestrictedPython-3.6.0.zip"; sha256 = "0edb2579b4174282bee3997abc6316d122c7ca6dcd02f4423352213cde571434"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/RestrictedPython";
        license = licenses.zpl21;
        description = "RestrictedPython provides a restricted execution environment for Python, e.g. for running untrusted code.";
      };
    };



    "Unidecode" = python.mkDerivation {
      name = "Unidecode-0.4.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d2/c0/fd82d57ad948f005c8d96211249d3cb34ee57289d8e9eecf6bdda70b4bd6/Unidecode-0.04.1.tar.gz"; sha256 = "e3687492791cf9088fb17ac69b3d77223eeb13107fa6eff1806d6b63f9306343"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.tablix.org/~avian/blog/archives/2009/01/unicode_transliteration_in_python/";
        license = "";
        description = "US-ASCII transliterations of Unicode text";
      };
    };



    "ZConfig" = python.mkDerivation {
      name = "ZConfig-2.9.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/6f/b9/730a2d0bd2fb67c4a2dddbc99c646825c473c7eb2b7bd57821d7f9049b31/ZConfig-2.9.3.tar.gz"; sha256 = "28aae6309cbf14fdf446a4d7331476633fdb07f0cdbc2bde1d1ab34a1c1f447d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.zope.org/Members/fdrake/zconfig/";
        license = licenses.zpl21;
        description = "Structured Configuration Library";
      };
    };



    "ZODB3" = python.mkDerivation {
      name = "ZODB3-3.10.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/34/5f/5604cdaa9be530e4cfb5a9c885fbe83b63629865d036ec2748003180307c/ZODB3-3.10.7.tar.gz"; sha256 = "be923c78ca39b1a7cdc2a6692bd9851c1e376c6339dd614ca6da37a38a204a9f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZConfig"
      self."transaction"
      self."zc.lockfile"
      self."zdaemon"
      self."zope.event"
      self."zope.interface"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.zpl21;
        description = "Zope Object Database: object database and persistence";
      };
    };



    "ZServer" = python.mkDerivation {
      name = "ZServer-3.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d1/ef/66c295ac915158e544b8df67a43e10edaf9620e9ab07a3a8d95398325f21/ZServer-3.0.zip"; sha256 = "4dd2c907a67b5d3414f722230ff25743ac83900faf3214bb93ab8d4cbcc2a97c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/ZServer";
        license = licenses.zpl21;
        description = "Zope 2 ZServer.";
      };
    };



    "Zope2" = python.mkDerivation {
      name = "Zope2-2.13.26";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/74/5f/7013d8a9a6c6bbfbf56c0739beb86f4883e8132236b3bb52de84673d0a14/Zope2-2.13.26.tar.gz"; sha256 = "a9196925f7a4ffebb21559bbc9497c8c6d35600d051421f1457cba9fab2746f2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."AccessControl"
      self."Acquisition"
      self."DateTime"
      self."DocumentTemplate"
      self."ExtensionClass"
      self."Missing"
      self."MultiMapping"
      self."Persistence"
      self."Products.BTreeFolder2"
      self."Products.ExternalMethod"
      self."Products.MIMETools"
      self."Products.MailHost"
      self."Products.OFSP"
      self."Products.PythonScripts"
      self."Products.Sessions"
      self."Products.StandardCacheManagers"
      self."Products.TemporaryFolder"
      self."Products.ZCTextIndex"
      self."Products.ZCatalog"
      self."Record"
      self."RestrictedPython"
      self."ZConfig"
      self."ZODB3"
      self."ZServer"
      self."ZopeUndo"
      self."docutils"
      self."initgroups"
      self."pytz"
      self."tempstorage"
      self."transaction"
      self."zExceptions"
      self."zLOG"
      self."zdaemon"
      self."zope.browser"
      self."zope.browsermenu"
      self."zope.browserpage"
      self."zope.browserresource"
      self."zope.component"
      self."zope.configuration"
      self."zope.container"
      self."zope.contentprovider"
      self."zope.contenttype"
      self."zope.deferredimport"
      self."zope.event"
      self."zope.exceptions"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.location"
      self."zope.pagetemplate"
      self."zope.processlifetime"
      self."zope.proxy"
      self."zope.ptresource"
      self."zope.publisher"
      self."zope.schema"
      self."zope.security"
      self."zope.sendmail"
      self."zope.sequencesort"
      self."zope.site"
      self."zope.size"
      self."zope.structuredtext"
      self."zope.tal"
      self."zope.tales"
      self."zope.testbrowser"
      self."zope.testing"
      self."zope.traversing"
      self."zope.viewlet"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://zope2.zope.org";
        license = licenses.zpl21;
        description = "Zope2 application server / web framework";
      };
    };



    "ZopeUndo" = python.mkDerivation {
      name = "ZopeUndo-2.12.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/59/b3/891937a2193b0a6a9c6a058ec3a426be75b7a83c9409b2bebe5d2a6d67ba/ZopeUndo-2.12.0.zip"; sha256 = "5f2c077a23834773668a9badcffcaa227d2ee9b231d20ed8103b19be5cdf343d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/ZopeUndo";
        license = licenses.zpl21;
        description = "ZODB undo support for Zope2.";
      };
    };



    "archetypes.multilingual" = python.mkDerivation {
      name = "archetypes.multilingual-3.0.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1b/ff/bdbc87daa31f9e5b664f07c2c6ee06802dfe2444c95e8007c27a7c5c9cab/archetypes.multilingual-3.0.5.tar.gz"; sha256 = "9dc45edb1463b5b096d2d265cca02d8e413ab4d158d29a8e0fe31015e1df10f3"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.ATContentTypes"
      self."collective.monkeypatcher"
      self."plone.app.multilingual"
      self."plone.app.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/archetypes.multilingual";
        license = "GPL";
        description = "Multilingual support for archetypes.";
      };
    };



    "archetypes.schemaextender" = python.mkDerivation {
      name = "archetypes.schemaextender-2.1.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/78/03/491c926676496d0608aaf4ab1dcb356ca2172e35a4d0b69ecdd450db0590/archetypes.schemaextender-2.1.7.tar.gz"; sha256 = "c19dea782af608719c739e02c76e569417d57f52427d4af678432fa4b59387f0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."plone.uuid"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/archetypes.schemaextender";
        license = "GPL";
        description = "Dynamically extend Archetypes schemas with named adapters.";
      };
    };



    "argh" = python.mkDerivation {
      name = "argh-0.26.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e3/75/1183b5d1663a66aebb2c184e0398724b624cecd4f4b679cb6e25de97ed15/argh-0.26.2.tar.gz"; sha256 = "e9535b8c84dc9571a48999094fda7f33e63c3f1b74f3e5f3ac0105a58405bb65"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/neithere/argh/";
        license = licenses.lgpl2;
        description = "An unobtrusive argparse wrapper with natural syntax";
      };
    };



    "args" = python.mkDerivation {
      name = "args-0.1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e5/1c/b701b3f4bd8d3667df8342f311b3efaeab86078a840fb826bd204118cc6b/args-0.1.0.tar.gz"; sha256 = "a785b8d837625e9b61c39108532d95b85274acd679693b71ebb5156848fcf814"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kennethreitz/args";
        license = licenses.bsdOriginal;
        description = "Command Arguments for Humans.";
      };
    };



    "borg.localrole" = python.mkDerivation {
      name = "borg.localrole-3.1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fa/96/a00725c5a7d6dfec33b0d9f8700cce1d141fe410310080f5290944d78253/borg.localrole-3.1.3.tar.gz"; sha256 = "fed9c2ebc09326cd06d94f06c92aebad54294c804427dd7d3bc9a22ceedf398d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFCore"
      self."Products.GenericSetup"
      self."Products.PlonePAS"
      self."Products.PluggableAuthService"
      self."Zope2"
      self."plone.app.testing"
      self."plone.memoize"
      self."zope.annotation"
      self."zope.component"
      self."zope.deferredimport"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/borg.localrole";
        license = licenses.lgpl2;
        description = "A PAS plugin which can manage local roles via an adapter lookup on the current context";
      };
    };



    "check-manifest" = python.mkDerivation {
      name = "check-manifest-0.35";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/10/f2/7f397f3f7d088b0720dc3e19cf5bde15baa489c9054a0d09793ededd2c07/check-manifest-0.35.tar.gz"; sha256 = "f9b7a3a6071f1991009bfa760f903b6d31f7b852a35d76a1cbbbcd1b22c9f44a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mgedmin/check-manifest";
        license = licenses.mit;
        description = "Check MANIFEST.in in a Python source package for completeness";
      };
    };



    "clint" = python.mkDerivation {
      name = "clint-0.5.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/3d/b4/41ecb1516f1ba728f39ee7062b9dac1352d39823f513bb6f9e8aeb86e26d/clint-0.5.1.tar.gz"; sha256 = "05224c32b1075563d0b16d0015faaf9da43aa214e4a2140e51f08789e7a4c5aa"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."args"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kennethreitz/clint";
        license = licenses.isc;
        description = "Python Command Line Interface Tools";
      };
    };



    "collective.elephantvocabulary" = python.mkDerivation {
      name = "collective.elephantvocabulary-0.2.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/93/f1/a86cb423095229d11544199a5cd64151deffdacc85bda28b300ea3ee7602/collective.elephantvocabulary-0.2.5.zip"; sha256 = "a3f4ef008767007845ac7f792fd468936c192adc33d0be945814b8a609a8c01b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."plone.registry"
      self."plone.testing"
      self."zope.component"
      self."zope.dottedname"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/collective/collective.elephantvocabulary";
        license = licenses.gpl1;
        description = "type of zope vocabularies that dont \"forget\", like                    elephants";
      };
    };



    "collective.monkeypatcher" = python.mkDerivation {
      name = "collective.monkeypatcher-1.1.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/45/75/01e1e4cd8b13ffe3081a0b8cb45e3f1df49c93389a128dd6cee567666dfb/collective.monkeypatcher-1.1.2.tar.gz"; sha256 = "2a6b19d204a22235b23201d47f59e37cb2adc7ccc7c700630659a2c2576b3fc2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/collective.monkeypatcher";
        license = licenses.bsdOriginal;
        description = "Support for applying monkey patches late in the startup cycle by using ZCML configuration actions";
      };
    };



    "colorama" = python.mkDerivation {
      name = "colorama-0.3.9";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e6/76/257b53926889e2835355d74fec73d82662100135293e17d382e2b74d1669/colorama-0.3.9.tar.gz"; sha256 = "48eb22f4f8461b1df5734a074b57042430fb06e1d61bd1e11b078c0fe6d7a1f1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/tartley/colorama";
        license = licenses.bsdOriginal;
        description = "Cross-platform colored terminal text.";
      };
    };



    "configparser" = python.mkDerivation {
      name = "configparser-3.5.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/7c/69/c2ce7e91c89dc073eb1aa74c0621c3eefbffe8216b3f9af9d3885265c01c/configparser-3.5.0.tar.gz"; sha256 = "5308b47021bc2340965c371f0f058cc6971a04502638d4244225c49d80db273a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docs.python.org/3/library/configparser.html";
        license = licenses.mit;
        description = "This library brings the updated configparser from Python 3.5 to Python 2.6-3.5.";
      };
    };



    "cssmin" = python.mkDerivation {
      name = "cssmin-0.2.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8e/d8/dc9da69bb186303f7ab41adef0a5b6d34da2fdba006827620877760241c3/cssmin-0.2.0.tar.gz"; sha256 = "e012f0cc8401efcf2620332339011564738ae32be8c84b2e43ce8beaec1067b6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/zacharyvoase/cssmin";
        license = "";
        description = "A Python port of the YUI CSS compression algorithm.";
      };
    };



    "cssselect" = python.mkDerivation {
      name = "cssselect-0.9.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/11/21/47b5d2696a945da177d2344b6e330b7b0d1c52404063cb387d2261517ccb/cssselect-0.9.2.tar.gz"; sha256 = "713b5b99ef08022257b3409c7ae1b18b2c6536b3f155e6237c5cfba0f67ae6f5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pythonhosted.org/cssselect/";
        license = licenses.bsdOriginal;
        description = "cssselect parses CSS3 Selectors and translates them to XPath 1.0";
      };
    };



    "decorator" = python.mkDerivation {
      name = "decorator-4.0.10";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/13/8a/4eed41e338e8dcc13ca41c94b142d4d20c0de684ee5065523fee406ce76f/decorator-4.0.10.tar.gz"; sha256 = "9c6e98edcb33499881b86ede07d9968c81ab7c769e28e9af24075f0a5379f070"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/micheles/decorator";
        license = licenses.bsdOriginal;
        description = "Better living through Python with decorators";
      };
    };



    "diazo" = python.mkDerivation {
      name = "diazo-1.2.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/45/71/92fd79b633b4998cc0e0862de5757348945c4630b49a03d1a283fa4c0dfd/diazo-1.2.5.tar.gz"; sha256 = "c50721babc21870b1af8f0f345741e5e7d87f5a16b63126268c1115ac5409a31"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."cssselect"
      self."future"
      self."lxml"
      self."repoze.xmliter"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://diazo.org";
        license = "New BSD";
        description = "Diazo implements a Deliverance like language using a pure
        XSLT engine. With Diazo, you \"compile\" your theme and ruleset in one
        step, then use a superfast/simple transform on each request thereafter.
        Alternatively, compile your theme during development, check it into
        version control, and not touch Diazo during deployment.";
      };
    };



    "docutils" = python.mkDerivation {
      name = "docutils-0.12";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/37/38/ceda70135b9144d84884ae2fc5886c6baac4edea39550f28bcd144c1234d/docutils-0.12.tar.gz"; sha256 = "c7db717810ab6965f66c8cf0398a98c9d8df982da39b4cd7f162911eb89596fa"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docutils.sourceforge.net/";
        license = licenses.publicDomain;
        description = "Docutils -- Python Documentation Utilities";
      };
    };



    "enum34" = python.mkDerivation {
      name = "enum34-1.1.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/bf/3e/31d502c25302814a7c2f1d3959d2a3b3f78e509002ba91aea64993936876/enum34-1.1.6.tar.gz"; sha256 = "8ad8c4783bf61ded74527bffb48ed9b54166685e4230386a9ed9b1279e2df5b1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/stoneleaf/enum34";
        license = licenses.bsdOriginal;
        description = "Python 3.4 Enum backported to 3.3, 3.2, 3.1, 2.7, 2.6, 2.5, and 2.4";
      };
    };



    "feedparser" = python.mkDerivation {
      name = "feedparser-5.2.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/91/d8/7d37fec71ff7c9dbcdd80d2b48bcdd86d6af502156fc93846fb0102cb2c4/feedparser-5.2.1.tar.bz2"; sha256 = "ce875495c90ebd74b179855449040003a1beb40cd13d5f037a0654251e260b02"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kurtmckee/feedparser";
        license = "License :: OSI Approved";
        description = "Universal feed parser, handles RSS 0.9x, RSS 1.0, RSS 2.0, CDF, Atom 0.3, and Atom 1.0 feeds";
      };
    };



    "five.customerize" = python.mkDerivation {
      name = "five.customerize-1.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/6e/01/7c6898d76b50608141e84d3092760f8b078b65b46b4b556fa7d25e589e1b/five.customerize-1.1.zip"; sha256 = "3c1cb663c3bc9e8245291768f708e634b6da0bdd55a2c94e9c8e4a29623ad809"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Zope2"
      self."plone.portlets"
      self."transaction"
      self."zope.component"
      self."zope.componentvocabulary"
      self."zope.dottedname"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.pagetemplate"
      self."zope.publisher"
      self."zope.schema"
      self."zope.site"
      self."zope.testing"
      self."zope.traversing"
      self."zope.viewlet"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/five.customerize";
        license = licenses.zpl21;
        description = "TTW customization of template-based Zope views";
      };
    };



    "five.globalrequest" = python.mkDerivation {
      name = "five.globalrequest-1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d8/0a/7517a99f29dc49dc35e46c6e1a43fddaeccb5a4c960564e58a2a97a16180/five.globalrequest-1.0.tar.gz"; sha256 = "f861e68e0c2397ab84091263753964159fde7e89d19e667a632ac0e625eb5346"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
      self."zope.globalrequest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/five.globalrequest";
        license = "ZPL";
        description = "Zope 2 integration for zope.globalrequest";
      };
    };



    "five.intid" = python.mkDerivation {
      name = "five.intid-1.1.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/5e/3d/40a43573e939b605e2d6b8fc1ac9add98f11a196ddb04c1674eaebbf147c/five.intid-1.1.2.tar.gz"; sha256 = "706e6444a1e9b1783c3982d35cdb8722a014e4f25998e41549d1b258c730e513"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Zope2"
      self."five.localsitemanager"
      self."zope.component"
      self."zope.event"
      self."zope.interface"
      self."zope.intid"
      self."zope.keyreference"
      self."zope.lifecycleevent"
      self."zope.location"
      self."zope.site"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/five.intid";
        license = "ZPL";
        description = "Zope2 support for zope.intid";
      };
    };



    "five.localsitemanager" = python.mkDerivation {
      name = "five.localsitemanager-2.0.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/0e/16/261e57dd64de6014effa7c74aa2d01cea4680610f3b5c10199a80c62a117/five.localsitemanager-2.0.6.tar.gz"; sha256 = "d5b19001af36a3a98ded01fefdd664509d06a8d374f2293d4d97aa406fa7af8d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."ZODB3"
      self."Zope2"
      self."zope.component"
      self."zope.event"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.location"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/five.localsitemanager";
        license = licenses.zpl21;
        description = "Local site manager implementation for Zope.";
      };
    };



    "five.pt" = python.mkDerivation {
      name = "five.pt-2.2.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/66/b7/ebdf949b754425138c7285f7d1c94295e7399f8090b3f93c149eabb1d9af/five.pt-2.2.4.tar.gz"; sha256 = "d9617d397ddf66d90debc243275fec661d61ee8594475712eb86ede47b6b1d50"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Chameleon"
      self."sourcecodegen"
      self."z3c.pt"
      self."zope.pagetemplate"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/five.pt";
        license = "ZPL";
        description = "Five bridges and patches to use Chameleon with Zope.";
      };
    };



    "flake8" = python.mkDerivation {
      name = "flake8-3.5.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1e/ab/7730f6d6cdf73a3b7f98a2fe3b2cdf68e9e760a4a133e083607497d4c3a6/flake8-3.5.0.tar.gz"; sha256 = "7253265f7abd8b313e3892944044a365e3f4ac3fcdcfb4298f55ee9ddf188ba0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."configparser"
      self."enum34"
      self."mccabe"
      self."pycodestyle"
      self."pyflakes"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://gitlab.com/pycqa/flake8";
        license = licenses.mit;
        description = "the modular source code checker: pep8, pyflakes and co";
      };
    };



    "flake8-blind-except" = python.mkDerivation {
      name = "flake8-blind-except-0.1.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ff/f2/ab635e6e420e78c94eab50cd3f53abd3ec27e411793e50b14f29edbb9f0b/flake8-blind-except-0.1.1.tar.gz"; sha256 = "aca3356633825544cec51997260fe31a8f24a1a2795ce8e81696b9916745e599"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/elijahandrews/flake8-blind-except";
        license = licenses.mit;
        description = "A flake8 extension that checks for blind except: statements";
      };
    };



    "flake8-coding" = python.mkDerivation {
      name = "flake8-coding-1.3.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ae/26/3c6304d646f8ee27d6c40bfcd9874fea870098c3ef3cf60e284ea9db29ef/flake8-coding-1.3.0.tar.gz"; sha256 = "ba01e96f879377766a3d71f3499a832b19386ce4831270bfe671ab57d0fe50be"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/tk0miya/flake8-coding";
        license = licenses.asl20;
        description = "Adds coding magic comment checks to flake8";
      };
    };



    "flake8-debugger" = python.mkDerivation {
      name = "flake8-debugger-3.0.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/2c/a7/45823a26ef0c5fa7a0c099b772a5b6aa2d8e686284490ef738fc8691ffc0/flake8-debugger-3.0.0.tar.gz"; sha256 = "e5c8ac980d819db2f3fbb89fe0e43a2fe6c127edd6ce4984a3f7e0bbdac3d2d4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
      self."pycodestyle"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jbkahn/flake8-debugger";
        license = licenses.mit;
        description = "ipdb/pdb statement checker plugin for flake8";
      };
    };



    "flake8-deprecated" = python.mkDerivation {
      name = "flake8-deprecated-1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/28/28/d39539c84cfb432d7431255ed16f93125342ced4a137d653b50b621fae36/flake8-deprecated-1.3.tar.gz"; sha256 = "9fa5a0c5c81fb3b34c53a0e4f16cd3f0a3395078cfd4988011cbab5fb0afa7f7"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/gforcada/flake8-deprecated";
        license = licenses.gpl2;
        description = "Warns about deprecated method calls.";
      };
    };



    "flake8-isort" = python.mkDerivation {
      name = "flake8-isort-2.2.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/07/2b/196a65996ae39cf8d9c5edc7116b41ac06a605c7e8a2ca039cca8c050e5d/flake8-isort-2.2.2.tar.gz"; sha256 = "4b9ee1d9f790826fb576830f75635fb6a9092484939be67869953df027b42110"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
      self."flake8-polyfill"
      self."isort"
      self."testfixtures"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/gforcada/flake8-isort";
        license = licenses.gpl2;
        description = "flake8 plugin that integrates isort .";
      };
    };



    "flake8-pep3101" = python.mkDerivation {
      name = "flake8-pep3101-1.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/9b/79/86fc94b5580618a90494f974edfa063d4fcc72f01c0b7ee2904e5d7d952f/flake8-pep3101-1.1.tar.gz"; sha256 = "b57b42133b14dc4ac09169520cb8ebf4802db30babab98e1ebaf9f3a9da2c832"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
      self."testfixtures"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/gforcada/flake8-pep3101";
        license = licenses.gpl2;
        description = "Checks for old string formatting.";
      };
    };



    "flake8-plone-api" = python.mkDerivation {
      name = "flake8-plone-api-1.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/69/63/2855e8ec58991c49b8211ce6d4d4d8df969c93698ed914dbd27d6a5a1d46/flake8-plone-api-1.4.tar.gz"; sha256 = "cadba99badb6e07d8a0e623f0c53d5e8500b5a30cea63822fbebf68153c2dcf6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/gforcada/flake8-plone-api";
        license = licenses.gpl2;
        description = "Checks for code usages that can be replaced with Plone API method calls.";
      };
    };



    "flake8-plone-hasattr" = python.mkDerivation {
      name = "flake8-plone-hasattr-0.2.post0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/db/d4/63e659daf3b6d08854b7a6cd1d90743fe610cf33c4302ab0484d88ce2c49/flake8-plone-hasattr-0.2.post0.tar.gz"; sha256 = "f72ef91a47de847f80749a3668aad89fb23f0e6dcf93a1100b0e909b9e378ec6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/gforcada/flake8-plone-hasattr";
        license = licenses.gpl2;
        description = "Checks for hasattr, which is considered harmful in Plone projects.";
      };
    };



    "flake8-polyfill" = python.mkDerivation {
      name = "flake8-polyfill-1.0.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/71/6e/dd7e0f0ddf146213d0cc0b963b3d4c6434823ebe3992c29b523182bbf785/flake8-polyfill-1.0.1.tar.gz"; sha256 = "c77056b1e2cfce7b39d7634370062baf02438962a7d176ea717627b83b17f609"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://gitlab.com/pycqa/flake8";
        license = licenses.mit;
        description = "Polyfill package for Flake8 plugins";
      };
    };



    "flake8-print" = python.mkDerivation {
      name = "flake8-print-3.0.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e6/78/2fe5d8aec4feed46957a043fe7eb9b08af39db597674494c80ed164720bf/flake8-print-3.0.1.tar.gz"; sha256 = "255b01f0932f65fb8ce70a65f0f2abb4a05faf25f9fe53275cd13cacdc0179f5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
      self."pycodestyle"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jbkahn/flake8-print";
        license = licenses.mit;
        description = "print statement checker plugin for flake8";
      };
    };



    "flake8-quotes" = python.mkDerivation {
      name = "flake8-quotes-0.12.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a0/4f/60ff2549d4b4abb3665f7019184652f5bd9a421ad7312cc1aef644317441/flake8-quotes-0.12.0.zip"; sha256 = "1469fe554777f81b3a0be0b828663e400b028fde36d86a03c7c8a036c8ecaca4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/zheller/flake8-quotes/";
        license = licenses.mit;
        description = "Flake8 lint for quotes.";
      };
    };



    "flake8-string-format" = python.mkDerivation {
      name = "flake8-string-format-0.2.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/df/1f/a16f1a1a0b3abf067c56ac7261fd167820bc612f3345eea20a9d57d60e6f/flake8-string-format-0.2.3.tar.gz"; sha256 = "774d56103d9242ed968897455ef49b7d6de272000cfa83de5814273a868832f1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."flake8"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/xZise/flake8-string-format";
        license = licenses.mit;
        description = "string format checker, plugin for flake8";
      };
    };



    "flake8-todo" = python.mkDerivation {
      name = "flake8-todo-0.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/97/44/4ddfdb3cf642d51858d81472b71e77fd4fb409699f4e9072faf5ae3b4cf9/flake8-todo-0.7.tar.gz"; sha256 = "6e4c5491ff838c06fe5a771b0e95ee15fc005ca57196011011280fc834a85915"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pycodestyle"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/schlamar/flake8-todo";
        license = licenses.mit;
        description = "TODO notes checker, plugin for flake8";
      };
    };



    "future" = python.mkDerivation {
      name = "future-0.15.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/5a/f4/99abde815842bc6e97d5a7806ad51236630da14ca2f3b1fce94c0bb94d3d/future-0.15.2.tar.gz"; sha256 = "3d3b193f20ca62ba7d8782589922878820d0a023b885882deec830adbf639b97"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://python-future.org";
        license = licenses.mit;
        description = "Clean single-source support for Python 3 and 2";
      };
    };



    "icalendar" = python.mkDerivation {
      name = "icalendar-3.11.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/bb/6a/486b4a882d03042e569a40a4e17aebcb1d8d2b8f54620007adaba43c67af/icalendar-3.11.4.tar.gz"; sha256 = "5696b18f791bbbb5972b87ea3d3c42a855ae641b0608477a451aa23f7defa347"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."python-dateutil"
      self."pytz"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/collective/icalendar";
        license = licenses.bsdOriginal;
        description = "iCalendar parser/generator";
      };
    };



    "initgroups" = python.mkDerivation {
      name = "initgroups-2.13.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/bc/a5/b31a91d30f8008f7c8a8e1a56549f291fd0d5f4569ca7be6cc4bb033a83b/initgroups-2.13.0.zip"; sha256 = "b34e1c9f2ec7c1a3bb602df9a0bb6027e18f0bdbe12288c437ab3cf7d8a91138"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/initgroups";
        license = licenses.zpl21;
        description = "Convenience uid/gid helper function used in Zope2.";
      };
    };



    "isort" = python.mkDerivation {
      name = "isort-4.2.15";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4d/d5/7c8657126a43bcd3b0173e880407f48be4ac91b4957b51303eab744824cf/isort-4.2.15.tar.gz"; sha256 = "79f46172d3a4e2e53e7016e663cc7a8b538bec525c36675fcfd2767df30b3983"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/timothycrosley/isort";
        license = licenses.mit;
        description = "A Python utility / library to sort Python imports.";
      };
    };



    "lxml" = python.mkDerivation {
      name = "lxml-3.5.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8b/be/ed850baac891aca25c832fb8d7b9c0e7a5077a30e336d95ffc7d649aaa06/lxml-3.5.0.tar.gz"; sha256 = "349f93e3a4b09cc59418854ab8013d027d246757c51744bf20069bc89016f578"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."cssselect"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://lxml.de/";
        license = licenses.bsdOriginal;
        description = "Powerful and Pythonic XML processing library combining libxml2/libxslt with the ElementTree API.";
      };
    };



    "mailinglogger" = python.mkDerivation {
      name = "mailinglogger-3.8.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b3/fe/a945dc5c3facb7db809b5562b142b1a93ca4d410b2a4cc4a8cd564181a96/mailinglogger-3.8.0.tar.gz"; sha256 = "46c36d17d3776910d730091c4c8031405ea1cbe09551d278d8f7652bf3c86a52"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.simplistix.co.uk/software/python/mailinglogger";
        license = licenses.mit;
        description = "Enhanced emailing handlers for the python logging package.";
      };
    };



    "mccabe" = python.mkDerivation {
      name = "mccabe-0.6.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/06/18/fa675aa501e11d6d6ca0ae73a101b2f3571a565e0f7d38e062eec18a91ee/mccabe-0.6.1.tar.gz"; sha256 = "dd8d182285a0fe56bace7f45b5e7d1a6ebcbf524e8f3bd87eb0f125271b8831f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pycqa/mccabe";
        license = licenses.mit;
        description = "McCabe checker, plugin for flake8";
      };
    };



    "mechanize" = python.mkDerivation {
      name = "mechanize-0.2.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/32/bc/d5b44fe4a3b5079f035240a7c76bd0c71a60c6082f4bfcb1c7585604aa35/mechanize-0.2.5.tar.gz"; sha256 = "2e67b20d107b30c00ad814891a095048c35d9d8cb9541801cebe85684cc84766"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://wwwsearch.sourceforge.net/mechanize/";
        license = licenses.bsdOriginal;
        description = "Stateful programmatic web browsing.";
      };
    };



    "mockup" = python.mkDerivation {
      name = "mockup-2.1.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/bb/d6/2c74028c311d3932a44cb0c790c32b06c5c68fde3571d8a017c36a1dda6d/mockup-2.1.7.tar.gz"; sha256 = "2022c1f4b4b879bf896281e6284fcb1fa682592d140a5b2cf94d3070275aca73"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/mockup";
        license = licenses.bsdOriginal;
        description = "A collection of client side patterns for faster and easier web development";
      };
    };



    "nt-svcutils" = python.mkDerivation {
      name = "nt-svcutils-2.13.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/58/82/1d706ec25859f575cb29bc87096957df34531f71453b3ba45364ee007058/nt_svcutils-2.13.0.zip"; sha256 = "9f7993511f62b5fb9fb7ca74e122067d4146ae047f7930078636333ed54d1e8d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/nt_svcutils";
        license = licenses.zpl21;
        description = "nt_svcutils for Zope2.";
      };
    };



    "olefile" = python.mkDerivation {
      name = "olefile-0.44";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/35/17/c15d41d5a8f8b98cc3df25eb00c5cee76193114c78e5674df6ef4ac92647/olefile-0.44.zip"; sha256 = "61f2ca0cd0aa77279eb943c07f607438edf374096b66332fae1ee64a6f0f73ad"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.decalage.info/python/olefileio";
        license = licenses.bsdOriginal;
        description = "Python package to parse, read and write Microsoft OLE2 files (Structured Storage or Compound Document, Microsoft Office) - Improved version of the OleFileIO module from PIL, the Python Image Library.";
      };
    };



    "pathtools" = python.mkDerivation {
      name = "pathtools-0.1.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e7/7f/470d6fcdf23f9f3518f6b0b76be9df16dcc8630ad409947f8be2eb0ed13a/pathtools-0.1.2.tar.gz"; sha256 = "7c35c5421a39bb82e58018febd90e3b6e5db34c5443aaaf742b3f33d4655f1c0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/gorakhargosh/pathtools";
        license = licenses.mit;
        description = "File system general utilities";
      };
    };



    "pkginfo" = python.mkDerivation {
      name = "pkginfo-1.4.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/58/54/57f7c5638fecdf232a5b6b767da467b0ff31467d7f86a7364c252acf2321/pkginfo-1.4.1.tar.gz"; sha256 = "bb1a6aeabfc898f5df124e7e00303a5b3ec9a489535f346bfbddb081af93f89e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://code.launchpad.net/~tseaver/pkginfo/trunk";
        license = licenses.mit;
        description = "Query metadatdata from sdists / bdists / installed packages.";
      };
    };



    "plone.alterego" = python.mkDerivation {
      name = "plone.alterego-1.1.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/89/96/5137c0784d7574747fb77b79346d127166f5dfe9069d058c6f826f4e138e/plone.alterego-1.1.1.tar.gz"; sha256 = "db47ef5344d2b2ef2fc1c6a34221aa7520a16dbe217443e5aefa7610465fcd08"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.component"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/plone.alterego";
        license = licenses.lgpl3;
        description = "Low level support for dynamic modules";
      };
    };



    "plone.api" = python.mkDerivation {
      name = "plone.api-1.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b5/7f/7b142a310896856970f3a4c3037895091732063da530682f6f792c5ab555/plone.api-1.7.tar.gz"; sha256 = "33236a058a2a80e9aa98c7cbf51446e5ac7c1247f0d12ada8676fdec9bb5bfe3"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.Archetypes"
      self."Products.CMFPlone"
      self."Products.statusmessages"
      self."decorator"
      self."flake8"
      self."plone.app.dexterity"
      self."plone.app.linkintegrity"
      self."plone.app.testing"
      self."plone.app.uuid"
      self."plone.indexer"
      self."plone.registry"
      self."plone.uuid"
      self."zest.releaser"
      self."zope.globalrequest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.api";
        license = licenses.gpl2;
        description = "A Plone API.";
      };
    };



    "plone.app.blob" = python.mkDerivation {
      name = "plone.app.blob-1.7.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f4/02/1480a17e861bed14712ad33d9a0a008ac1dbe4124bbe0351c84f7bbf8feb/plone.app.blob-1.7.2.tar.gz"; sha256 = "b4d09bd3d12d321e82da9bf7258182c5cbd7905fa866a1c310f092a2acd6fe32"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.MimetypesRegistry"
      self."Products.contentmigration"
      self."ZODB3"
      self."archetypes.schemaextender"
      self."collective.monkeypatcher"
      self."plone.app.imaging"
      self."plone.app.testing"
      self."plone.scale"
      self."zope.proxy"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://plone.org/products/plone.app.blob";
        license = licenses.gpl1;
        description = "ZODB blob support for Plone";
      };
    };



    "plone.app.caching" = python.mkDerivation {
      name = "plone.app.caching-1.2.18";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/3f/de/1891cf7185ddc8b7b9c51b58a42a920d8dff287b217a433193b81b3bf62c/plone.app.caching-1.2.18.tar.gz"; sha256 = "9045628d5ef1c9f1137dd2cd7e4562e3d0fe532c4f73919a9e8a6a537497c71a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFCore"
      self."Products.CMFDynamicViewFTI"
      self."Products.GenericSetup"
      self."Products.statusmessages"
      self."Zope2"
      self."plone.app.contenttypes"
      self."plone.app.registry"
      self."plone.app.testing"
      self."plone.app.z3cform"
      self."plone.cachepurging"
      self."plone.caching"
      self."plone.memoize"
      self."plone.protect"
      self."plone.registry"
      self."python-dateutil"
      self."z3c.form"
      self."z3c.zcmlhook"
      self."zope.browserresource"
      self."zope.component"
      self."zope.interface"
      self."zope.pagetemplate"
      self."zope.publisher"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.caching";
        license = licenses.gpl1;
        description = "Plone UI and default rules for plone.caching/z3c.caching";
      };
    };



    "plone.app.collection" = python.mkDerivation {
      name = "plone.app.collection-1.1.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/78/23/08b8f17e9cbd0e70b326b03db5ab426a629baed6de0c3ea2fd60abafece4/plone.app.collection-1.1.7.tar.gz"; sha256 = "45488f12d916032fd1c3fcf0497d5b61684a71d5872e0efa20d5ae97396d3680"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.ATContentTypes"
      self."Products.Archetypes"
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Products.CMFQuickInstallerTool"
      self."Products.validation"
      self."Zope2"
      self."plone.app.contentlisting"
      self."plone.app.portlets"
      self."plone.app.querystring"
      self."plone.app.testing"
      self."plone.app.vocabularies"
      self."plone.app.widgets"
      self."plone.portlet.collection"
      self."plone.portlets"
      self."transaction"
      self."zope.component"
      self."zope.configuration"
      self."zope.formlib"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.collection";
        license = licenses.gpl1;
        description = "This package adds 'saved search' functionality to Plone.";
      };
    };



    "plone.app.content" = python.mkDerivation {
      name = "plone.app.content-3.4.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d1/62/886f4e8a446aab1dafded14c51c4c59d3d532391f7fe68dc70d54c1d1f2c/plone.app.content-3.4.1.tar.gz"; sha256 = "42ab8c4525189ed0b75b5fb7b479b64ab84b2ca0d6ae67f6005acc22f0f29e1f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFCore"
      self."Products.CMFDynamicViewFTI"
      self."Products.CMFPlone"
      self."Zope2"
      self."plone.app.contenttypes"
      self."plone.app.testing"
      self."plone.app.widgets"
      self."plone.batching"
      self."plone.i18n"
      self."plone.memoize"
      self."plone.protect"
      self."zope.component"
      self."zope.container"
      self."zope.deferredimport"
      self."zope.event"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.publisher"
      self."zope.schema"
      self."zope.viewlet"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.content";
        license = licenses.gpl1;
        description = "Content Views for Plone";
      };
    };



    "plone.app.contentlisting" = python.mkDerivation {
      name = "plone.app.contentlisting-1.2.9";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d0/e7/6a08b33deea48534942259ec3ab3e75b8e8176d5ee645a9b7d8d12dc2439/plone.app.contentlisting-1.2.9.tar.gz"; sha256 = "7dd2a76cc7ac128eff7ac7c6902b4f98b0aa469e197caaa8f1b24d39fefb8ff5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFPlone"
      self."plone.app.contenttypes"
      self."plone.app.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.contentlisting";
        license = "GPL version 2";
        description = "Listing of content for the Plone CMS";
      };
    };



    "plone.app.contentmenu" = python.mkDerivation {
      name = "plone.app.contentmenu-2.1.10";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/39/84/0ea2643189f3bc47cafeb4084b0fd0862551369be5e6f6a982ed0da5d14f/plone.app.contentmenu-2.1.10.tar.gz"; sha256 = "1130e89559e39d64dfadffbcab665969d833c98f38b59d4684702f7c6b64dea8"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFCore"
      self."Products.CMFDynamicViewFTI"
      self."Products.CMFPlone"
      self."Zope2"
      self."plone.app.content"
      self."plone.app.contenttypes"
      self."plone.app.testing"
      self."plone.locking"
      self."plone.memoize"
      self."plone.protect"
      self."zope.browsermenu"
      self."zope.component"
      self."zope.contentprovider"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.publisher"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.contentmenu";
        license = licenses.gpl1;
        description = "Plone's content menu implementation";
      };
    };



    "plone.app.contentrules" = python.mkDerivation {
      name = "plone.app.contentrules-4.0.16";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/27/14/8e6f06757808c5f093c3c064b83562e91060b4b9de113490051ad243bb7d/plone.app.contentrules-4.0.16.tar.gz"; sha256 = "9bfd52ab3fd316855145154294cafe8476e802cf02902797747212528b09753c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Products.GenericSetup"
      self."Products.statusmessages"
      self."ZODB3"
      self."Zope2"
      self."plone.app.testing"
      self."plone.app.vocabularies"
      self."plone.app.z3cform"
      self."plone.autoform"
      self."plone.contentrules"
      self."plone.memoize"
      self."plone.stringinterp"
      self."plone.uuid"
      self."transaction"
      self."zope.annotation"
      self."zope.browser"
      self."zope.component"
      self."zope.container"
      self."zope.event"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.publisher"
      self."zope.schema"
      self."zope.site"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.contentrules";
        license = licenses.gpl1;
        description = "Plone integration for plone.contentrules";
      };
    };



    "plone.app.contenttypes" = python.mkDerivation {
      name = "plone.app.contenttypes-1.2.23";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/28/99/8c14d06177e14d816a1e1c69ec53b5be588adf6c0b161c25ad8a86177011/plone.app.contenttypes-1.2.23.tar.gz"; sha256 = "5b2aef7430f7944908674507c81738599b23a66e891acbfaebea2b8a86357dbc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.ATContentTypes"
      self."Products.CMFPlone"
      self."Products.contentmigration"
      self."archetypes.schemaextender"
      self."lxml"
      self."plone.app.contentmenu"
      self."plone.app.dexterity"
      self."plone.app.event"
      self."plone.app.linkintegrity"
      self."plone.app.lockingbehavior"
      self."plone.app.querystring"
      self."plone.app.referenceablebehavior"
      self."plone.app.relationfield"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.app.versioningbehavior"
      self."plone.app.z3cform"
      self."plone.dexterity"
      self."plone.namedfile"
      self."pytz"
      self."zope.deprecation"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.app.contenttypes";
        license = "GPL";
        description = "Default content types for Plone based on Dexterity";
      };
    };



    "plone.app.controlpanel" = python.mkDerivation {
      name = "plone.app.controlpanel-3.0.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/19/fd/ad1eec5a59f96b7a99bd60d235052a73ca0be744ea26eec30117f203592f/plone.app.controlpanel-3.0.4.tar.gz"; sha256 = "9b9379d6ec9c11b1723be1dda51fe1a4c5bae8fbc4d499b1e408a45ac81c7545"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFPlone"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.controlpanel";
        license = licenses.gpl1;
        description = "Formlib-based controlpanels for Plone.";
      };
    };



    "plone.app.customerize" = python.mkDerivation {
      name = "plone.app.customerize-1.3.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b9/18/5e101264b1a20a001003f6b76c7daf427ec0bec90e9aa6dd0e875c5580c4/plone.app.customerize-1.3.7.tar.gz"; sha256 = "42f046fea549f6f531033579308d4dfd5f3ddd92236b665612a1bba7000e99c2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFCore"
      self."Zope2"
      self."five.customerize"
      self."plone.app.layout"
      self."plone.app.testing"
      self."plone.browserlayer"
      self."plone.portlets"
      self."zope.component"
      self."zope.interface"
      self."zope.publisher"
      self."zope.testing"
      self."zope.viewlet"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.customerize/";
        license = licenses.gpl1;
        description = "Integrate five.customerize into Plone.";
      };
    };



    "plone.app.dexterity" = python.mkDerivation {
      name = "plone.app.dexterity-2.3.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/26/66/d17da80faa4923091f533239f0b6c98180f2639dd32d98d9381e4531380f/plone.app.dexterity-2.3.7.tar.gz"; sha256 = "7f7a7aa42eae6c5eb5b1b6caf4b65fba73ec40e0095ac7139897bf40e12842b0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Products.GenericSetup"
      self."Zope2"
      self."lxml"
      self."plone.app.content"
      self."plone.app.intid"
      self."plone.app.layout"
      self."plone.app.relationfield"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.app.textfield"
      self."plone.app.uuid"
      self."plone.app.z3cform"
      self."plone.autoform"
      self."plone.behavior"
      self."plone.contentrules"
      self."plone.dexterity"
      self."plone.formwidget.namedfile"
      self."plone.namedfile"
      self."plone.portlets"
      self."plone.rfc822"
      self."plone.schemaeditor"
      self."plone.supermodel"
      self."plone.z3cform"
      self."z3c.form"
      self."z3c.relationfield"
      self."zope.browserpage"
      self."zope.component"
      self."zope.deprecation"
      self."zope.interface"
      self."zope.publisher"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://plone.org/products/dexterity";
        license = "GPL";
        description = "Dexterity is a content type framework for CMF  applications, with particular emphasis on Plone. It can be viewed as an alternative to Archetypes that is more light-weight and modular.";
      };
    };



    "plone.app.discussion" = python.mkDerivation {
      name = "plone.app.discussion-2.4.21";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e9/18/859c9bffb5f63390aedf5519ed2d1822c073375f02e5480f4d63e61cb764/plone.app.discussion-2.4.21.tar.gz"; sha256 = "6333bf40704ca7946f6875bb129e76ff610d93ab490f5db2bd36ae8bd19178c3"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFPlone"
      self."ZODB3"
      self."plone.app.contentrules"
      self."plone.app.contenttypes"
      self."plone.app.layout"
      self."plone.app.registry"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.app.uuid"
      self."plone.app.z3cform"
      self."plone.contentrules"
      self."plone.indexer"
      self."plone.registry"
      self."plone.stringinterp"
      self."plone.z3cform"
      self."z3c.form"
      self."zope.annotation"
      self."zope.component"
      self."zope.container"
      self."zope.event"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.site"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.discussion";
        license = "GPL";
        description = "Enhanced discussion support for Plone";
      };
    };



    "plone.app.event" = python.mkDerivation {
      name = "plone.app.event-2.0.13";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fd/76/1ccce7b2d55bd0ec57f8c803a27a45ff567ea917a3a82aa6844db2ab4d63/plone.app.event-2.0.13.tar.gz"; sha256 = "bbdd67917cf40450863b780ddca70111ed08e0afb84d1463f47a94ad839f7612"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Products.DateRecurringIndex"
      self."Products.GenericSetup"
      self."Products.ZCatalog"
      self."Products.statusmessages"
      self."Zope2"
      self."collective.elephantvocabulary"
      self."icalendar"
      self."plone.app.contentlisting"
      self."plone.app.contenttypes"
      self."plone.app.dexterity"
      self."plone.app.layout"
      self."plone.app.portlets"
      self."plone.app.querystring"
      self."plone.app.registry"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.app.textfield"
      self."plone.app.vocabularies"
      self."plone.app.widgets"
      self."plone.app.z3cform"
      self."plone.autoform"
      self."plone.behavior"
      self."plone.browserlayer"
      self."plone.dexterity"
      self."plone.event"
      self."plone.folder"
      self."plone.formwidget.recurrence"
      self."plone.indexer"
      self."plone.memoize"
      self."plone.namedfile"
      self."plone.portlets"
      self."plone.registry"
      self."plone.supermodel"
      self."plone.testing"
      self."plone.uuid"
      self."plone.z3cform"
      self."pytz"
      self."robotsuite"
      self."transaction"
      self."z3c.form"
      self."zExceptions"
      self."zope.annotation"
      self."zope.component"
      self."zope.container"
      self."zope.contentprovider"
      self."zope.event"
      self."zope.globalrequest"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.publisher"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.app.event";
        license = licenses.gpl2;
        description = "The Plone calendar framework";
      };
    };



    "plone.app.folder" = python.mkDerivation {
      name = "plone.app.folder-1.2.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1b/93/0731fe3ea5a8ba84af9f53446aa962776c1f88788d5cbe61248557bb6c93/plone.app.folder-1.2.3.tar.gz"; sha256 = "515771b052f6c47aa97a273ec39774cfc63be61f54d7a5e76a4fbb22654d5710"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.ATContentTypes"
      self."Products.Archetypes"
      self."Products.BTreeFolder2"
      self."Products.CMFCore"
      self."Products.GenericSetup"
      self."Zope2"
      self."plone.app.layout"
      self."plone.app.testing"
      self."plone.folder"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.folder/";
        license = licenses.gpl1;
        description = "Integration package for `plone.folder` into Plone";
      };
    };



    "plone.app.i18n" = python.mkDerivation {
      name = "plone.app.i18n-3.0.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c3/de/194a619b95a18e5ad5700f6143c5d0b637f1a4949b82d644d85634d4785b/plone.app.i18n-3.0.4.tar.gz"; sha256 = "006a7b2aabf5bc18daa6502f0116f2f552c14375252edca1d7ce4d4026d8e4bb"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."plone.app.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.i18n";
        license = licenses.gpl1;
        description = "Plone specific i18n extensions.";
      };
    };



    "plone.app.imaging" = python.mkDerivation {
      name = "plone.app.imaging-2.0.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c2/54/fcec07d8e7c4527ab673f394d7af4a13ba53711f927f3eb8c0a4ca20dcce/plone.app.imaging-2.0.6.tar.gz"; sha256 = "b8fa449518892437d518ec3faad82ea1ca0d4ca08a6971fe99847ae93addd7ce"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.ATContentTypes"
      self."Products.Archetypes"
      self."five.globalrequest"
      self."plone.app.testing"
      self."plone.scale"
      self."z3c.caching"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.imaging";
        license = licenses.gpl1;
        description = "User-configurable, blob-aware image scaling for Plone.";
      };
    };



    "plone.app.intid" = python.mkDerivation {
      name = "plone.app.intid-1.1.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/2b/fb/f4f2f4318248f3b11dda570fae90fcf45bb280b80d65f2f0a00cf5b43acc/plone.app.intid-1.1.2.tar.gz"; sha256 = "c3d7a72e96bdfc92009334ef393ef7f9729ae3000eb672373884e59d7d27f681"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."five.intid"
      self."plone.app.testing"
      self."plone.dexterity"
      self."zope.intid"
      self."zope.lifecycleevent"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.app.intid";
        license = "GPL";
        description = "Installation and migration support for five.intid within Plone/CMF";
      };
    };



    "plone.app.iterate" = python.mkDerivation {
      name = "plone.app.iterate-3.2.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4f/e0/c4661eb30f90e830deff2b17e5112965d15b0393d598faedbe2126d7cacb/plone.app.iterate-3.2.4.tar.gz"; sha256 = "664ac01c5015b5ef48eb59b8c5077e67af302c3301654a21a39853f57659f9fc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."Products.Archetypes"
      self."Products.CMFCore"
      self."Products.CMFEditions"
      self."Products.CMFPlacefulWorkflow"
      self."Products.DCWorkflow"
      self."Products.GenericSetup"
      self."Products.statusmessages"
      self."ZODB3"
      self."Zope2"
      self."plone.app.contenttypes"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.locking"
      self."plone.memoize"
      self."zope.annotation"
      self."zope.component"
      self."zope.event"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.schema"
      self."zope.viewlet"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.iterate";
        license = licenses.gpl1;
        description = "check-out/check-in staging for Plone";
      };
    };



    "plone.app.layout" = python.mkDerivation {
      name = "plone.app.layout-2.5.23";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/80/0b/0af3ac575f15bacced773fe883809bbbda0281278d851310f15c580b338c/plone.app.layout-2.5.23.tar.gz"; sha256 = "2d30a20708138e2199147f30e2d9bee4b1a2bd199c0c55c5b6430742b041f6c9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."Products.CMFCore"
      self."Products.CMFDynamicViewFTI"
      self."Products.CMFEditions"
      self."Products.CMFPlone"
      self."Zope2"
      self."plone.app.content"
      self."plone.app.contenttypes"
      self."plone.app.intid"
      self."plone.app.portlets"
      self."plone.app.relationfield"
      self."plone.app.testing"
      self."plone.app.viewletmanager"
      self."plone.batching"
      self."plone.dexterity"
      self."plone.i18n"
      self."plone.locking"
      self."plone.memoize"
      self."plone.portlets"
      self."plone.registry"
      self."plone.testing"
      self."z3c.relationfield"
      self."zope.annotation"
      self."zope.component"
      self."zope.deferredimport"
      self."zope.deprecation"
      self."zope.dottedname"
      self."zope.i18n"
      self."zope.interface"
      self."zope.publisher"
      self."zope.schema"
      self."zope.viewlet"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.layout";
        license = licenses.gpl1;
        description = "Layout mechanisms for Plone";
      };
    };



    "plone.app.linkintegrity" = python.mkDerivation {
      name = "plone.app.linkintegrity-3.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ea/bb/145881604cc6a796880e700d733e85eb743ef36683000e0b87ab1729cbfa/plone.app.linkintegrity-3.1.tar.gz"; sha256 = "c4afeb0d3a558d406da58a2c33378e6020757b6f74b9d8a6a9e1eece2030b4a4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."plone.app.contenttypes"
      self."plone.app.dexterity"
      self."plone.app.intid"
      self."plone.app.relationfield"
      self."plone.app.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.linkintegrity";
        license = licenses.gpl2;
        description = "Manage link integrity in Plone.";
      };
    };



    "plone.app.locales" = python.mkDerivation {
      name = "plone.app.locales-5.0.14";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/0c/ef/67d933d44cc4898789ab847f20397ac93c9132a2a383a2360b5f0e7dea00/plone.app.locales-5.0.14.tar.gz"; sha256 = "3701e9f7b6b78c86e7fe8cc99ef60fe863c2e5e904f9d15923c6b4c0bdbf67cc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/collective/plone.app.locales";
        license = licenses.gpl1;
        description = "Translation files for Plone";
      };
    };



    "plone.app.lockingbehavior" = python.mkDerivation {
      name = "plone.app.lockingbehavior-1.0.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f5/3b/f78cc16706e3919fa9de31d17c8124e0514042505b749182e4fadb355c92/plone.app.lockingbehavior-1.0.5.tar.gz"; sha256 = "b9a541cec9b05725a0b9eb897fff7149cb90b4e4150669885557320a67b52860"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."plone.app.locales"
      self."plone.app.testing"
      self."plone.behavior"
      self."plone.dexterity"
      self."plone.locking"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.app.lockingbehavior/";
        license = "GPL2";
        description = "Locking integration for dexterity content objects.";
      };
    };



    "plone.app.multilingual" = python.mkDerivation {
      name = "plone.app.multilingual-5.0.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/39/b6/c320565307836221c23eecd334b6d54ff34f6fc68a3574b2caa33ce4423f/plone.app.multilingual-5.0.7.tar.gz"; sha256 = "f01cf9f5525f091fd4b0642069a56e4d25dbcfd95beae98f84ea8009b5327f35"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFPlone"
      self."Products.GenericSetup"
      self."archetypes.multilingual"
      self."decorator"
      self."plone.app.contenttypes"
      self."plone.app.layout"
      self."plone.app.registry"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.app.z3cform"
      self."plone.behavior"
      self."plone.dexterity"
      self."z3c.relationfield"
      self."zope.publisher"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.app.multilingual";
        license = "GPL";
        description = "Multilingual Plone UI package, enables maintenance of translations for both Dexterity types and Archetypes";
      };
    };



    "plone.app.openid" = python.mkDerivation {
      name = "plone.app.openid-2.1.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d2/ad/d3a9ab1097817ad33da2aea94b12739aa97917c6d8bf419afc01d2063ec5/plone.app.openid-2.1.1.tar.gz"; sha256 = "ada46026cba1675e47132514571c21b79f68d88e774b3190189db6662d083526"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFPlone"
      self."Products.PlonePAS"
      self."Products.PluggableAuthService"
      self."Zope2"
      self."plone.app.portlets"
      self."plone.app.testing"
      self."plone.openid"
      self."plone.portlets"
      self."zope.component"
      self."zope.i18nmessageid"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.openid";
        license = licenses.gpl1;
        description = "Plone OpenID authentication support";
      };
    };



    "plone.app.portlets" = python.mkDerivation {
      name = "plone.app.portlets-3.1.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e7/80/9e6edc84cbd3fc6bba631a63718b5ed7b804a304f905bf70403843c2c53a/plone.app.portlets-3.1.5.tar.gz"; sha256 = "f48ede5864401a1eb46170646f4ac37212ccab1bd0379d1e39bbb6c805eb3ae9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."Products.ATContentTypes"
      self."Products.CMFCore"
      self."Products.CMFDynamicViewFTI"
      self."Products.CMFPlone"
      self."Products.GenericSetup"
      self."Products.PluggableAuthService"
      self."ZODB3"
      self."Zope2"
      self."feedparser"
      self."five.customerize"
      self."plone.app.blob"
      self."plone.app.i18n"
      self."plone.app.layout"
      self."plone.app.testing"
      self."plone.app.vocabularies"
      self."plone.i18n"
      self."plone.memoize"
      self."plone.portlets"
      self."transaction"
      self."zope.annotation"
      self."zope.browser"
      self."zope.component"
      self."zope.configuration"
      self."zope.container"
      self."zope.contentprovider"
      self."zope.event"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.publisher"
      self."zope.schema"
      self."zope.site"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.portlets";
        license = licenses.gpl1;
        description = "Plone integration for the basic plone.portlets package";
      };
    };



    "plone.app.querystring" = python.mkDerivation {
      name = "plone.app.querystring-1.3.17";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ec/2f/4fb12e53422a73be0de803f2f2d9471870dfbc4baec21e2190d3e9562017/plone.app.querystring-1.3.17.tar.gz"; sha256 = "e1a8a1650bf8295043d8380ca2adf2fc4f5ea6205f6fd7bc256c42ad2b94b82f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."DateTime"
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."plone.app.contentlisting"
      self."plone.app.layout"
      self."plone.app.registry"
      self."plone.app.testing"
      self."plone.app.vocabularies"
      self."plone.batching"
      self."plone.registry"
      self."python-dateutil"
      self."zope.component"
      self."zope.dottedname"
      self."zope.globalrequest"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.publisher"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.querystring";
        license = licenses.gpl1;
        description = "A queryparser, querybuilder and extra helper tools, to parse stored queries to actual results, used in new style Plone collections";
      };
    };



    "plone.app.redirector" = python.mkDerivation {
      name = "plone.app.redirector-1.3.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fc/cf/420f7cc7397306783dd8577377020b4b669ff3a97b4599f04be0b03fd200/plone.app.redirector-1.3.4.tar.gz"; sha256 = "425f33289ea4cacaf340e56edb30ef373bc0ecc2890d74fac2a5d0775b1d7f94"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."plone.app.contenttypes"
      self."plone.app.testing"
      self."plone.memoize"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.redirector";
        license = licenses.gpl1;
        description = "redirection tool";
      };
    };



    "plone.app.referenceablebehavior" = python.mkDerivation {
      name = "plone.app.referenceablebehavior-0.7.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/58/9a/08fbc650cb5810ecaa1aa84c260c4a298ba3bca022926b732f49b6d3a9ab/plone.app.referenceablebehavior-0.7.7.tar.gz"; sha256 = "1b5229a8a25409d9e960accda32352e2fa86aec1394ab4340f0de4188d930714"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.Archetypes"
      self."Products.CMFPlone"
      self."plone.app.dexterity"
      self."plone.app.locales"
      self."plone.app.testing"
      self."plone.behavior"
      self."plone.dexterity"
      self."plone.indexer"
      self."plone.uuid"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://plone.org/products/dexterity";
        license = "GPL";
        description = "Referenceable dexterity type behavior";
      };
    };



    "plone.app.registry" = python.mkDerivation {
      name = "plone.app.registry-1.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/90/66/e43e9dce34a08af7c42d912752d0930ef6fe54ce1f50c7b3b6f2b9cf86f3/plone.app.registry-1.5.tar.gz"; sha256 = "cc161810b836c66ac7577a4f51a23a56ba075f43ebb40fe96757ceb46c0edccc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Products.GenericSetup"
      self."Products.statusmessages"
      self."Zope2"
      self."lxml"
      self."plone.app.testing"
      self."plone.app.z3cform"
      self."plone.autoform"
      self."plone.registry"
      self."plone.supermodel"
      self."zope.component"
      self."zope.dottedname"
      self."zope.i18nmessageid"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.registry";
        license = "GPL";
        description = "Zope 2 and Plone  integration for plone.registry";
      };
    };



    "plone.app.relationfield" = python.mkDerivation {
      name = "plone.app.relationfield-1.3.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/93/5c/f9b8383c3a17eae76c22606d1f171525b1136d5b89d1135a97338a8d17a3/plone.app.relationfield-1.3.4.tar.gz"; sha256 = "0b6983b59a5492a98aed5d1d840c8d6defc6fc4d6bd54ccee3f40a7346e0f735"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."five.intid"
      self."plone.app.dexterity"
      self."plone.app.intid"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.app.vocabularies"
      self."plone.app.z3cform"
      self."plone.autoform"
      self."plone.rfc822"
      self."plone.schemaeditor"
      self."plone.supermodel"
      self."z3c.form"
      self."z3c.formwidget.query"
      self."z3c.relationfield"
      self."zope.component"
      self."zope.interface"
      self."zope.intid"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.relationfield";
        license = "GPL";
        description = "Plone support for z3c.relationfield";
      };
    };



    "plone.app.robotframework" = python.mkDerivation {
      name = "plone.app.robotframework-1.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/bb/f4/106d9e77ff762cf04bcd1bae52c452a58c414614e757e73411d9565790db/plone.app.robotframework-1.1.tar.gz"; sha256 = "c35386492eede4c8f2496fd83374c8ddea60821fc39afa1e493b2b2bf0e7d34c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Babel"
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Products.MailHost"
      self."Products.PlonePAS"
      self."Products.PluggableAuthService"
      self."five.globalrequest"
      self."plone.app.dexterity"
      self."plone.app.testing"
      self."plone.app.textfield"
      self."plone.dexterity"
      self."plone.testing"
      self."plone.uuid"
      self."robotframework"
      self."robotframework-debuglibrary"
      self."robotframework-selenium2library"
      self."robotsuite"
      self."selenium"
      self."watchdog"
      self."z3c.form"
      self."zope.component"
      self."zope.configuration"
      self."zope.i18n"
      self."zope.schema"
      self."zope.testrunner"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.app.robotframework/";
        license = "gpl";
        description = "Robot Framework testing resources for Plone";
      };
    };



    "plone.app.testing" = python.mkDerivation {
      name = "plone.app.testing-5.0.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/6e/28/4090118c641c0a51e8b1ce78dd8ec18cc803d6fe283e1e0676fb5f9aedeb/plone.app.testing-5.0.6.tar.gz"; sha256 = "ddfd818caf6e997cc0bb9b9df04c54bb0bcc24c33a138f26d30057fd96217b03"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.ATContentTypes"
      self."Products.CMFCore"
      self."Products.CMFPlacefulWorkflow"
      self."Products.CMFPlone"
      self."Products.GenericSetup"
      self."Products.PluggableAuthService"
      self."Zope2"
      self."decorator"
      self."five.localsitemanager"
      self."plone.memoize"
      self."plone.testing"
      self."robotframework-selenium2library"
      self."robotsuite"
      self."selenium"
      self."transaction"
      self."zope.component"
      self."zope.configuration"
      self."zope.dottedname"
      self."zope.interface"
      self."zope.publisher"
      self."zope.testing"
      self."zope.testrunner"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.testing";
        license = licenses.gpl1;
        description = "Testing tools for Plone-the-application, based on plone.testing.";
      };
    };



    "plone.app.textfield" = python.mkDerivation {
      name = "plone.app.textfield-1.2.8";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c8/f9/502d53aaede9518f9422bb70ff3d308185489f5f6df463807e0c29fb45bc/plone.app.textfield-1.2.8.tar.gz"; sha256 = "b87492a5a1974298fb5959774a900319cc6eb1e53a8ca60ce491d61338cd96c2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.PortalTransforms"
      self."ZODB3"
      self."plone.app.testing"
      self."plone.rfc822"
      self."plone.schemaeditor"
      self."plone.supermodel"
      self."z3c.form"
      self."zope.component"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.textfield";
        license = "GPL";
        description = "Text field with MIME type support";
      };
    };



    "plone.app.theming" = python.mkDerivation {
      name = "plone.app.theming-1.3.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/9f/79/6d73cd9d2c79d59ae73045890ce62abf82b84e3baf0b839c333f7303a9b3/plone.app.theming-1.3.6.tar.gz"; sha256 = "a76e0ec0b407accb182e5dd04319723f3d2a071568fac705821e9493df50340a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFPlone"
      self."diazo"
      self."docutils"
      self."five.globalrequest"
      self."lxml"
      self."plone.app.registry"
      self."plone.app.testing"
      self."plone.resource"
      self."plone.resourceeditor"
      self."plone.subrequest"
      self."plone.transformchain"
      self."repoze.xmliter"
      self."roman"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.theming";
        license = "GPL";
        description = "Integrates the Diazo theming engine with Plone";
      };
    };



    "plone.app.upgrade" = python.mkDerivation {
      name = "plone.app.upgrade-2.0.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/33/19/1a4050949299cd5f63628fb41c7de34233bad79ade3ec271e813a7e23e6d/plone.app.upgrade-2.0.4.tar.gz"; sha256 = "903d05059684dfa782a26f715b1798d3ec1f8a639c703c8811bcc81945eb8b7a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFCore"
      self."Products.CMFEditions"
      self."Products.CMFPlone"
      self."Products.CMFQuickInstallerTool"
      self."Products.GenericSetup"
      self."Products.PlonePAS"
      self."Products.PluggableAuthService"
      self."Products.ZCatalog"
      self."Zope2"
      self."plone.app.caching"
      self."plone.app.folder"
      self."plone.app.iterate"
      self."plone.app.testing"
      self."plone.app.theming"
      self."plone.app.viewletmanager"
      self."plone.contentrules"
      self."plone.portlets"
      self."transaction"
      self."zope.component"
      self."zope.interface"
      self."zope.ramcache"
      self."zope.site"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.upgrade";
        license = licenses.gpl1;
        description = "Upgrade machinery for Plone.";
      };
    };



    "plone.app.users" = python.mkDerivation {
      name = "plone.app.users-2.3.8";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/70/09/faca23334edc9dae7065aa874cc68b29bd99fdd32aa28aa7dec528ff0650/plone.app.users-2.3.8.tar.gz"; sha256 = "2b78ccef7d1dc4563e3f238af984ccc19b116cb38a10cfdf547f477340efb58b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."AccessControl"
      self."Acquisition"
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Products.MailHost"
      self."Products.PlonePAS"
      self."Products.statusmessages"
      self."ZODB3"
      self."Zope2"
      self."plone.app.controlpanel"
      self."plone.app.layout"
      self."plone.app.testing"
      self."plone.autoform"
      self."plone.formwidget.namedfile"
      self."plone.keyring"
      self."plone.namedfile"
      self."plone.protect"
      self."plone.schema"
      self."plone.uuid"
      self."z3c.form"
      self."zope.component"
      self."zope.event"
      self."zope.interface"
      self."zope.schema"
      self."zope.site"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.users";
        license = licenses.gpl1;
        description = "A package for all things users and groups related (specific to plone)";
      };
    };



    "plone.app.uuid" = python.mkDerivation {
      name = "plone.app.uuid-1.1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/07/58/1c710160bafd960b5224b99f5513c5348ccb9555e4d9bb86aa281904f8d8/plone.app.uuid-1.1.3.tar.gz"; sha256 = "fb24bea7983f581910a5f8aaf31519d229be2b95b92107ef590c8b356a9654b1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.Archetypes"
      self."plone.app.testing"
      self."plone.dexterity"
      self."plone.indexer"
      self."plone.uuid"
      self."zope.interface"
      self."zope.publisher"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://plone.org";
        license = "GPL";
        description = "Plone integration for the basic plone.uuid package";
      };
    };



    "plone.app.versioningbehavior" = python.mkDerivation {
      name = "plone.app.versioningbehavior-1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/bd/6a/ea88a6d3fcb3218456661f2428f75c183994e064d9597a8aca9e5d57be31/plone.app.versioningbehavior-1.3.tar.gz"; sha256 = "70b16b540ad15772734cb5de84bf34f29e19c29ed096f326d2b67781b8719670"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFDiffTool"
      self."Products.CMFEditions"
      self."Products.CMFPlone"
      self."plone.app.dexterity"
      self."plone.app.testing"
      self."plone.autoform"
      self."plone.behavior"
      self."plone.dexterity"
      self."plone.namedfile"
      self."plone.rfc822"
      self."zope.container"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://plone.org/products/dexterity";
        license = licenses.gpl1;
        description = "Provides a behavior for using CMFEditions with dexterity content types";
      };
    };



    "plone.app.viewletmanager" = python.mkDerivation {
      name = "plone.app.viewletmanager-2.0.10";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/86/e0/ea8e3d4f438ab21607cc6bad0d4892cb96a92c01db46f4d3e24d3a913789/plone.app.viewletmanager-2.0.10.tar.gz"; sha256 = "d1ff7b938b8f484e2cf8a01518cbc04986adc3a1641df23ee70c3fa744ef30f8"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFPlone"
      self."Products.GenericSetup"
      self."ZODB3"
      self."Zope2"
      self."plone.app.testing"
      self."plone.app.vocabularies"
      self."zope.component"
      self."zope.contentprovider"
      self."zope.interface"
      self."zope.publisher"
      self."zope.site"
      self."zope.viewlet"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.viewletmanager";
        license = licenses.gpl1;
        description = "Configurable viewlet manager";
      };
    };



    "plone.app.vocabularies" = python.mkDerivation {
      name = "plone.app.vocabularies-4.0.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/0e/01/55c669dc82e031dad0880c78e077e091d31ff79729a58883c142c9d088b8/plone.app.vocabularies-4.0.3.tar.gz"; sha256 = "72847b0e90e5d0a00e8a5e2f4c72193e7229e2e6df86bee84299bbf45d09f933"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFCore"
      self."Zope2"
      self."plone.app.querystring"
      self."plone.app.testing"
      self."pytz"
      self."zope.browser"
      self."zope.component"
      self."zope.configuration"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
      self."zope.site"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.app.vocabularies";
        license = licenses.gpl1;
        description = "Collection of generally useful vocabularies for Plone.";
      };
    };



    "plone.app.widgets" = python.mkDerivation {
      name = "plone.app.widgets-2.0.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/58/68/49c0b584204b75151b0dba1a341696c7561d27c2c1694f793fa733803328/plone.app.widgets-2.0.7.tar.gz"; sha256 = "78051685e7e156f07eaa28ca43dfed77c019b06c645182e29d1cfd407e8fbd37"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."DateTime"
      self."Products.Archetypes"
      self."Products.CMFPlone"
      self."Products.ResourceRegistries"
      self."archetypes.schemaextender"
      self."five.globalrequest"
      self."plone.app.contenttypes"
      self."plone.app.dexterity"
      self."plone.app.event"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.app.vocabularies"
      self."plone.app.z3cform"
      self."pytz"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.app.widgets";
        license = "GPL";
        description = "better plone widgets";
      };
    };



    "plone.app.workflow" = python.mkDerivation {
      name = "plone.app.workflow-2.2.8";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/98/94/1f6acb543d786855bade66e61ba00d8ae4174ceeb5c2dbf689fa2d7c57fa/plone.app.workflow-2.2.8.tar.gz"; sha256 = "b5859699e1d52607c7b8acb4026436c0f9aed954fb2895308efbb1a74b96ea63"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Products.DCWorkflow"
      self."Products.GenericSetup"
      self."Products.statusmessages"
      self."Zope2"
      self."plone.app.testing"
      self."plone.memoize"
      self."transaction"
      self."zope.component"
      self."zope.dottedname"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.schema"
      self."zope.site"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.workflow";
        license = licenses.gpl1;
        description = "workflow and security settings for Plone";
      };
    };



    "plone.app.z3cform" = python.mkDerivation {
      name = "plone.app.z3cform-1.2.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/13/f2/06575cab24fa71c311e5c725b510e0a3914fc977198f1336a9822039f4fd/plone.app.z3cform-1.2.3.tar.gz"; sha256 = "31edbb6498121edf1f579dbae4d6e70dd501f708e73684a970afbb8dcfcd0ca7"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Zope2"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.app.textfield"
      self."plone.app.widgets"
      self."plone.browserlayer"
      self."plone.protect"
      self."plone.testing"
      self."plone.z3cform"
      self."z3c.form"
      self."z3c.formwidget.query"
      self."zope.browserpage"
      self."zope.component"
      self."zope.contentprovider"
      self."zope.globalrequest"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.publisher"
      self."zope.schema"
      self."zope.testing"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.app.z3cform";
        license = "GPL";
        description = "A collection of widgets, templates and other components for use with z3c.form and Plone";
      };
    };



    "plone.autoform" = python.mkDerivation {
      name = "plone.autoform-1.6.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c3/c3/6634081a1dab3f20977c8ad86aad45417dd8c423d3f6f83e20c7511cba73/plone.autoform-1.6.2.tar.gz"; sha256 = "b104a48a7ee2a7bd5f20839f37518829eeea7603db5377f0901fe6386828f2e6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."plone.supermodel"
      self."plone.z3cform"
      self."z3c.form"
      self."zope.dottedname"
      self."zope.interface"
      self."zope.schema"
      self."zope.security"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://code.google.com/p/dexterity";
        license = licenses.lgpl3;
        description = "Tools to construct z3c.form forms";
      };
    };



    "plone.batching" = python.mkDerivation {
      name = "plone.batching-1.1.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1e/ac/81920c71421b206ae386340c7c444e2e2485373314a20a4123af5febb101/plone.batching-1.1.1.tar.gz"; sha256 = "ee157d8be8483d14ff9d30759928da834d0dd4c6aaa256e533de9b3368635d49"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.batching";
        license = "GPL";
        description = "Batching facilities used in Plone.";
      };
    };



    "plone.behavior" = python.mkDerivation {
      name = "plone.behavior-1.2.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/da/8a/6d3835aff726af481761c56f9ee9bb2bc267bd8a780725ce5f1f36d0f353/plone.behavior-1.2.0.tar.gz"; sha256 = "8fb45be19fb0a6b2602a5c965d33b5368972eb8c0c721fcb2fe5b0e2d06de69c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.annotation"
      self."zope.component"
      self."zope.configuration"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.behavior";
        license = licenses.bsdOriginal;
        description = "Infrastructure for maintaining a registry of available behaviors";
      };
    };



    "plone.browserlayer" = python.mkDerivation {
      name = "plone.browserlayer-2.2.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/30/98/5f2ffa75f45f590c8bd794afe3c467ce05cf73100aa3efc1d67b36b40e7f/plone.browserlayer-2.2.0.tar.gz"; sha256 = "045255a055b59741046b14f5b708c95254c143e5c86e4bdd42a35a59df894618"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."Products.GenericSetup"
      self."Zope2"
      self."plone.app.testing"
      self."zope.component"
      self."zope.interface"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.browserlayer";
        license = licenses.gpl1;
        description = "Browser layer management for Zope 2 applications";
      };
    };



    "plone.cachepurging" = python.mkDerivation {
      name = "plone.cachepurging-1.0.13";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8a/76/f09e06ed08b087868fbd11df49bb516d919bf35e22df4adfa2ab4da518bc/plone.cachepurging-1.0.13.tar.gz"; sha256 = "94ec3e27a95a9c0f8328a1cd3de77becb10dafae006694f28c1292c7930442e2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
      self."five.globalrequest"
      self."plone.app.testing"
      self."plone.registry"
      self."z3c.caching"
      self."zope.annotation"
      self."zope.component"
      self."zope.event"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.schema"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.cachepurging";
        license = "GPL version 2";
        description = "Cache purging support for Zope 2 applications";
      };
    };



    "plone.caching" = python.mkDerivation {
      name = "plone.caching-1.1.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/43/89/e5e457c9e6219615315396683d9f82f19697825bc4100bd9bc4d200c0e95/plone.caching-1.1.2.tar.gz"; sha256 = "ba4c6d560db2f9c5ddf4594d61c3ed09b73586bb3c4a362414fe0bce5dab9dd0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
      self."five.globalrequest"
      self."plone.registry"
      self."plone.transformchain"
      self."z3c.caching"
      self."zope.component"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.caching";
        license = "GPL";
        description = "Zope 2 integration for z3c.caching";
      };
    };



    "plone.contentrules" = python.mkDerivation {
      name = "plone.contentrules-2.0.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f1/fe/1b3a2af381330ace618ea961744258266ad2f88a258228be20f45f94f53c/plone.contentrules-2.0.6.tar.gz"; sha256 = "01be35eb3f67b54b82f9301b62e61cde2f658b2a61320c7aa72b98cbbc8b680c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.annotation"
      self."zope.component"
      self."zope.componentvocabulary"
      self."zope.configuration"
      self."zope.container"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.schema"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.contentrules";
        license = licenses.gpl1;
        description = "Plone ContentRules Engine";
      };
    };



    "plone.dexterity" = python.mkDerivation {
      name = "plone.dexterity-2.4.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/99/d5/4d2bc87e549205b4d59ee67368d0c9c1bb8037611b9e19e867eb2bb7bf4e/plone.dexterity-2.4.5.tar.gz"; sha256 = "9c0ff2ff96b8bacdbdcacf512d754b78c9445bcbc7a72429c67955f8050476fe"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."DateTime"
      self."Products.CMFCore"
      self."Products.CMFDynamicViewFTI"
      self."Products.statusmessages"
      self."ZODB3"
      self."Zope2"
      self."plone.alterego"
      self."plone.autoform"
      self."plone.behavior"
      self."plone.folder"
      self."plone.memoize"
      self."plone.rfc822"
      self."plone.supermodel"
      self."plone.synchronize"
      self."plone.testing"
      self."plone.uuid"
      self."plone.z3cform"
      self."zope.annotation"
      self."zope.browser"
      self."zope.component"
      self."zope.container"
      self."zope.dottedname"
      self."zope.filerepresentation"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.location"
      self."zope.publisher"
      self."zope.schema"
      self."zope.security"
      self."zope.size"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.dexterity";
        license = "GPL version 2";
        description = "Framework for content types as filesystem code and TTW (Zope/CMF/Plone)";
      };
    };



    "plone.event" = python.mkDerivation {
      name = "plone.event-1.3.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1f/39/39eeeb171875aa7c9c7deac0d8e8df774bb5565944a41cece5991f4b9859/plone.event-1.3.3.tar.gz"; sha256 = "d7440a51090e802c4b395eb38aabfd8af7c1552c94987efe3bb8f5c066ddccfd"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."DateTime"
      self."python-dateutil"
      self."pytz"
      self."zope.component"
      self."zope.configuration"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.event";
        license = "GPL";
        description = "Event and calendaring related tools not bound to Plone";
      };
    };



    "plone.folder" = python.mkDerivation {
      name = "plone.folder-1.0.9";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/12/7e/aef62fe1746f0715b23d321333e50454e5df661fb6f5e54558a27dfc72e4/plone.folder-1.0.9.tar.gz"; sha256 = "14025ef5e420f9a43955ed9ee3a2a2d1451166b9e80cb92a47e9d55d20ace7f2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.BTreeFolder2"
      self."Products.CMFCore"
      self."Products.ZCatalog"
      self."Zope2"
      self."plone.memoize"
      self."zope.annotation"
      self."zope.component"
      self."zope.container"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.folder";
        license = licenses.gpl1;
        description = "BTree-based folder implementation with order support";
      };
    };



    "plone.formwidget.namedfile" = python.mkDerivation {
      name = "plone.formwidget.namedfile-1.0.15";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b5/7f/767887082ea98086f24032e914e68915a8817c4b997ba14706db81cdfdf9/plone.formwidget.namedfile-1.0.15.tar.gz"; sha256 = "58f6ec8cbab396b933f2021a829f8d436d1e226204465bb3b87e20b2f2503b33"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."plone.namedfile"
      self."plone.z3cform"
      self."z3c.form"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.formwidget.namedfile";
        license = "GPL";
        description = "Image widget for z3c.form and Plone";
      };
    };



    "plone.formwidget.recurrence" = python.mkDerivation {
      name = "plone.formwidget.recurrence-2.1.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e3/94/47c1b404c49f3f909dcc9c052ce619a80018e8748a57c2e7496ca31cc22f/plone.formwidget.recurrence-2.1.1.tar.gz"; sha256 = "72fdd4e0fd0e9fccba2d5323586b036398385114581b22931fa54cd9f411080e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.ATContentTypes"
      self."Products.Archetypes"
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Products.GenericSetup"
      self."Products.validation"
      self."plone.app.testing"
      self."plone.app.z3cform"
      self."python-dateutil"
      self."z3c.form"
      self."zope.component"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.formwidget.recurrence";
        license = "GPL";
        description = "Recurrence widget for Plone";
      };
    };



    "plone.i18n" = python.mkDerivation {
      name = "plone.i18n-3.0.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/39/d9/0fc40006a3b0bc8eb6602114d3995d2ccefa57affdff825a9396a1c4664c/plone.i18n-3.0.7.tar.gz"; sha256 = "84389f48764ee768b14b6979c28844c5c7ad4c3288950d1b8a5efb0d803e2270"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."Products.CMFPlone"
      self."Unidecode"
      self."Zope2"
      self."plone.registry"
      self."zope.browserresource"
      self."zope.component"
      self."zope.configuration"
      self."zope.i18n"
      self."zope.interface"
      self."zope.publisher"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.i18n";
        license = licenses.gpl1;
        description = "Advanced i18n/l10n features";
      };
    };



    "plone.indexer" = python.mkDerivation {
      name = "plone.indexer-1.0.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c0/7e/5d297081eb6373a142749d5dc506a82cc3ce5d9dc603f737048b2608ac2d/plone.indexer-1.0.4.tar.gz"; sha256 = "56fd1479c4ea4221cb13d0188be1c57817c444690ed9e5931c3f9e0d772c4aea"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."Products.ZCatalog"
      self."zope.component"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.indexer";
        license = licenses.bsdOriginal;
        description = "Hooks to facilitate managing custom index values in Zope 2/CMF applications";
      };
    };



    "plone.intelligenttext" = python.mkDerivation {
      name = "plone.intelligenttext-2.1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a7/51/ad14d8e969349e8163e0c7a06e13198963e500321901ab10ec86d3bcb334/plone.intelligenttext-2.1.0.tar.gz"; sha256 = "f6c6d31369def051c933392351ba6fe0e0698f40d2da002f88dbc7e58a1d9a5b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/plone.intelligenttext";
        license = licenses.gpl1;
        description = "Provides transforms from text/x-web-intelligent to text/html and vice versa.";
      };
    };



    "plone.keyring" = python.mkDerivation {
      name = "plone.keyring-3.0.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fc/ad/1575d35235722c80b1a330f45c3bf6f95c093e329c7aeee4dc538aa8940d/plone.keyring-3.0.1.tar.gz"; sha256 = "76b0746f356920300141f334bebba4df3c10136052efcd0a4c015d26177c6b95"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.container"
      self."zope.interface"
      self."zope.location"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/plone.keyring";
        license = licenses.gpl1;
        description = "Manage secrets";
      };
    };



    "plone.locking" = python.mkDerivation {
      name = "plone.locking-2.1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e0/3e/8947ce72053f8962e41d8be44c936d29e67b2be2c1f5c56d4b24cb944828/plone.locking-2.1.3.tar.gz"; sha256 = "cc18a289208965e4748cf4e2111d7a6bae594a240c758afb6cdf03034ee70885"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."DateTime"
      self."Products.Archetypes"
      self."Products.CMFCore"
      self."ZODB3"
      self."Zope2"
      self."plone.app.testing"
      self."zope.annotation"
      self."zope.component"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
      self."zope.viewlet"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.locking";
        license = licenses.gpl1;
        description = "webdav locking support";
      };
    };



    "plone.memoize" = python.mkDerivation {
      name = "plone.memoize-1.2.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/3d/75/f25737398ade9891c79395d9dbe1296eac0f1731a29ed26e23508ebf0cf0/plone.memoize-1.2.0.tar.gz"; sha256 = "1cc06c6fb9be02ee03a28d407a14a225c4d19b4e640fda2581e5da460347fdc2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
      self."zope.annotation"
      self."zope.component"
      self."zope.configuration"
      self."zope.interface"
      self."zope.publisher"
      self."zope.ramcache"
      self."zope.testrunner"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.memoize";
        license = licenses.gpl1;
        description = "Decorators for caching the values of functions and methods";
      };
    };



    "plone.namedfile" = python.mkDerivation {
      name = "plone.namedfile-3.0.11";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/33/c4/1a6d4191acab61e5ff949d3b75d065af85ff957de1a1adbc23645cafa382/plone.namedfile-3.0.11.tar.gz"; sha256 = "145846eca3a8e231d31f1dfc71159326619c59db5c9c97adc07a02813924d919"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Pillow"
      self."Zope2"
      self."lxml"
      self."plone.rfc822"
      self."plone.scale"
      self."plone.schemaeditor"
      self."plone.supermodel"
      self."zope.app.file"
      self."zope.browserpage"
      self."zope.component"
      self."zope.copy"
      self."zope.security"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.namedfile";
        license = licenses.bsdOriginal;
        description = "File types and fields for images, files and blob files with filenames";
      };
    };



    "plone.openid" = python.mkDerivation {
      name = "plone.openid-2.0.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ff/45/3d911eb1aa92afdd9a823856898292dae809c902dc514292eb9d5f84bd2b/plone.openid-2.0.4.zip"; sha256 = "785ab11d2791a694e83a630eccf029ded7642f82334fe6f6a5fbafbbac822612"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Acquisition"
      self."Products.PluggableAuthService"
      self."ZODB3"
      self."Zope2"
      self."python-openid"
      self."transaction"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.openid";
        license = licenses.bsdOriginal;
        description = "OpenID authentication support for PAS";
      };
    };



    "plone.outputfilters" = python.mkDerivation {
      name = "plone.outputfilters-3.0.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8e/4d/fc43eaa8e4d597ee9cc5a0ee53c642df33006760489b895087b99e60cc63/plone.outputfilters-3.0.1.tar.gz"; sha256 = "dc006c6d87dbaa5f93d01f912176ac5b24700aa3dbd5aa5cf6c131470f659abc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."Products.GenericSetup"
      self."Products.MimetypesRegistry"
      self."Products.PortalTransforms"
      self."Unidecode"
      self."plone.app.contenttypes"
      self."plone.app.robotframework"
      self."plone.app.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/plone/plone.outputfilters";
        license = "GPL";
        description = "Transformations applied to HTML in Plone text fields as they are rendered";
      };
    };



    "plone.portlet.collection" = python.mkDerivation {
      name = "plone.portlet.collection-3.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d6/d4/cdea4b92520a61844cf00048eeeda8c7f2e11533ea980b6bf0d84beedc66/plone.portlet.collection-3.1.tar.gz"; sha256 = "91b22c6625b38344b0d430b85eb72ceff1435ddef460f6462152c65d215bb58c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."plone.app.contenttypes"
      self."plone.app.portlets"
      self."plone.app.testing"
      self."plone.app.vocabularies"
      self."plone.memoize"
      self."plone.portlets"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.portlet.collection";
        license = licenses.gpl1;
        description = "A portlet that fetches results from a collection";
      };
    };



    "plone.portlet.static" = python.mkDerivation {
      name = "plone.portlet.static-3.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/0f/49/c82717a2640b31fb6d676771634ab43455ad4e97519f04ea0436cea818de/plone.portlet.static-3.1.tar.gz"; sha256 = "f77904e35ca37c331545671a7d43c4dfa81edebbdc423302c24d96fbeb6b6558"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
      self."plone.app.portlets"
      self."plone.app.testing"
      self."plone.app.textfield"
      self."plone.i18n"
      self."plone.portlets"
      self."zope.component"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.portlet.static";
        license = licenses.gpl1;
        description = "An editable static HTML portlet for Plone.";
      };
    };



    "plone.portlets" = python.mkDerivation {
      name = "plone.portlets-2.2.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8b/8d/ffc1a640b83a5acc28f630c6900c137a71ca53c53fd75f0d13e63d394747/plone.portlets-2.2.3.tar.gz"; sha256 = "d5731b0537d5fa98fe6992ddff8209f34d2cc1c08f55a6d2d57b884543cd536c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."plone.memoize"
      self."zope.annotation"
      self."zope.browserpage"
      self."zope.component"
      self."zope.configuration"
      self."zope.container"
      self."zope.contentprovider"
      self."zope.interface"
      self."zope.location"
      self."zope.publisher"
      self."zope.schema"
      self."zope.security"
      self."zope.site"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.portlets";
        license = licenses.gpl1;
        description = "An extension of zope.viewlet to support dynamic portlets";
      };
    };



    "plone.protect" = python.mkDerivation {
      name = "plone.protect-3.0.23";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b7/2f/cdc62c5fb9739e0c5e91412f7df7678417f45e17ecc6368ccb03005596d0/plone.protect-3.0.23.tar.gz"; sha256 = "13c79a97b6557637b0e6ef51612cc7a9393491b1a01c6a475afebf70871067b6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFPlone"
      self."Zope2"
      self."collective.monkeypatcher"
      self."five.globalrequest"
      self."plone.app.testing"
      self."plone.keyring"
      self."plone.transformchain"
      self."repoze.xmliter"
      self."zope.component"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.protect";
        license = licenses.bsdOriginal;
        description = "Security for browser forms";
      };
    };



    "plone.recipe.codeanalysis" = python.mkDerivation {
      name = "plone.recipe.codeanalysis-2.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ef/0c/031a06ef77922453230a6359988e7d18e5f13be5df4d1c3551bdf8e151a2/plone.recipe.codeanalysis-2.2.tar.gz"; sha256 = "cf11a5965eeeec0f85a9ab03e14b1d914671ab5d7db4a98d6b3f83063a20f2ef"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."check-manifest"
      self."flake8"
      self."flake8-blind-except"
      self."flake8-coding"
      self."flake8-debugger"
      self."flake8-deprecated"
      self."flake8-isort"
      self."flake8-pep3101"
      self."flake8-plone-api"
      self."flake8-plone-hasattr"
      self."flake8-print"
      self."flake8-quotes"
      self."flake8-string-format"
      self."flake8-todo"
      self."testfixtures"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/plone/plone.recipe.codeanalysis/";
        license = licenses.gpl1;
        description = "Static code analysis for buildout-based Python projects.";
      };
    };



    "plone.recipe.zope2instance" = python.mkDerivation {
      name = "plone.recipe.zope2instance-4.2.22";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1c/b9/ef0b99ce12588e2d2bcc5e4f7162109fa411985df6a2f68307e1d1f3b904/plone.recipe.zope2instance-4.2.22.tar.gz"; sha256 = "6959b08154a27efba32bc45d81524459b4f2db6abe021faddefcadc06b5bd0d4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."Zope2"
      self."mailinglogger"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.recipe.zope2instance";
        license = licenses.zpl21;
        description = "Buildout recipe for creating a Zope 2 instance";
      };
    };



    "plone.registry" = python.mkDerivation {
      name = "plone.registry-1.0.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ba/00/90524a37a0436f581fdaa587b94ffdf6645d24d6cb74cd1b61c04de8143a/plone.registry-1.0.5.tar.gz"; sha256 = "9bb3f068a918ed5930989fd6e01755cfe91d81b7a0c6a16ddc26ed5b000b8f44"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.component"
      self."zope.dottedname"
      self."zope.event"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.registry";
        license = "GPL";
        description = "Registry for application settings (like debconf/ about:config)";
      };
    };



    "plone.resource" = python.mkDerivation {
      name = "plone.resource-1.2.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f9/5b/ccbf25ec2c4d35d35470b3d291b4835bf59138110555b6e224b87507c17d/plone.resource-1.2.1.tar.gz"; sha256 = "1eef5c148f06b6c464608d5ac583fdbcf3765a34d9db6b0b755606a73f770130"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
      self."plone.app.testing"
      self."plone.caching"
      self."python-dateutil"
      self."unittest2"
      self."z3c.caching"
      self."zope.component"
      self."zope.configuration"
      self."zope.filerepresentation"
      self."zope.interface"
      self."zope.publisher"
      self."zope.schema"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.resource";
        license = "GPL";
        description = "Static files for Plone";
      };
    };



    "plone.resourceeditor" = python.mkDerivation {
      name = "plone.resourceeditor-2.0.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/30/dd/1f6268c7dc20afb3642ab9bf39a0a9acd8b3b7b7fc6693bd29d8e190595c/plone.resourceeditor-2.0.5.tar.gz"; sha256 = "921ef891a1f615c62c13bbd8b87e0518c6006cfbafc15983b01133545951e78f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
      self."plone.app.testing"
      self."plone.resource"
      self."zope.component"
      self."zope.interface"
      self."zope.publisher"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.resourceeditor";
        license = "GPL";
        description = "Integrates ACE editor into Plone";
      };
    };



    "plone.rfc822" = python.mkDerivation {
      name = "plone.rfc822-1.1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4b/4a/3c795e2e47e34dff42abc3e41261984d89cca605b48d989127e4b2d5dcd7/plone.rfc822-1.1.3.tar.gz"; sha256 = "54211a4855a2edb633c75e25884696c2582ffa160e7adaa6fad38d65821d0ca9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."plone.supermodel"
      self."plone.testing"
      self."python-dateutil"
      self."zope.component"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.rfc822";
        license = licenses.bsdOriginal;
        description = "RFC822 marshalling for zope.schema fields";
      };
    };



    "plone.scale" = python.mkDerivation {
      name = "plone.scale-1.4.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/6d/e2/8c37dd68cd171a98c3686b7290f2e270aae6140f551d9977715a98fc2db3/plone.scale-1.4.2.tar.gz"; sha256 = "23a5cd6ca82b5f468ac4f71cf468a5f2f7fa3a9f93559ccddfd17f047cfae12c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Persistence"
      self."Pillow"
      self."zope.annotation"
      self."zope.component"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.scale";
        license = licenses.bsdOriginal;
        description = "Image scaling";
      };
    };



    "plone.schema" = python.mkDerivation {
      name = "plone.schema-1.0.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/87/23/7aa4a5f299ca911d967b8896596f6add18447ff08d52f2f0a4aaed21bd31/plone.schema-1.0.0.tar.gz"; sha256 = "5ba714804d069ec090382a9c9e392723cdef2d80bbe5875616dbbcc718dc37a5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."plone.app.testing"
      self."plone.app.z3cform"
      self."z3c.form"
      self."zope.component"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://plone.org/";
        license = licenses.bsdOriginal;
        description = "Plone specific extensions and fields for zope schematas";
      };
    };



    "plone.schemaeditor" = python.mkDerivation {
      name = "plone.schemaeditor-2.0.17";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/90/d1/c98919f51d2dd805749738704211d31252435f15431975b70ba38dd4ab7a/plone.schemaeditor-2.0.17.tar.gz"; sha256 = "ecb88cdc840a7df0dc7df07f42b6ced845fd6fa913185ca039f452790b4bd4bf"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
      self."plone.app.dexterity"
      self."plone.app.robotframework"
      self."plone.app.testing"
      self."plone.autoform"
      self."plone.z3cform"
      self."z3c.form"
      self."zope.cachedescriptors"
      self."zope.component"
      self."zope.container"
      self."zope.globalrequest"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.publisher"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.schemaeditor";
        license = licenses.bsdOriginal;
        description = "Provides through-the-web editing of a zope schema/interface.";
      };
    };



    "plone.session" = python.mkDerivation {
      name = "plone.session-3.6.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/25/31/e68820ad88e4af8695cfc309b9ca15f9aadb3719100a874297323fc097fd/plone.session-3.6.1.tar.gz"; sha256 = "ba03531764c8ef383ed43036091a197287b674fbe3708f5c35dcf0cfa152095a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.PluggableAuthService"
      self."Zope2"
      self."plone.keyring"
      self."plone.protect"
      self."zope.component"
      self."zope.configuration"
      self."zope.interface"
      self."zope.publisher"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.session";
        license = licenses.bsdOriginal;
        description = "Session based auth tkt authentication for Zope";
      };
    };



    "plone.stringinterp" = python.mkDerivation {
      name = "plone.stringinterp-1.2.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ad/2e/e89fca17f4e8e9f25444b5402f0757795ec1350970f2ee99c949c8539c5b/plone.stringinterp-1.2.1.tar.gz"; sha256 = "edff2c8c10fbb69e2df3ca81d4b28e548bdf27530248f486f9814662a3445bdf"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."plone.app.contenttypes"
      self."plone.app.testing"
      self."plone.memoize"
      self."plone.testing"
      self."zope.i18n"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.stringinterp";
        license = licenses.gpl1;
        description = "Adaptable string interpolation";
      };
    };



    "plone.subrequest" = python.mkDerivation {
      name = "plone.subrequest-1.8";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/61/50/8075ba930263cd670bcaf1c6f559588d1a7003f16933f19c2385a7e02431/plone.subrequest-1.8.tar.gz"; sha256 = "010b108b46a068146f698833f3e29ce1d30f233c406b9ad5712a1dab69319a40"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.MimetypesRegistry"
      self."five.globalrequest"
      self."five.localsitemanager"
      self."plone.app.blob"
      self."plone.testing"
      self."zope.globalrequest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.subrequest/";
        license = licenses.gpl1;
        description = "Subrequests for Zope2";
      };
    };



    "plone.supermodel" = python.mkDerivation {
      name = "plone.supermodel-1.3.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/64/33/d91b22b114598906f9d588a25c69bf2f5442af33a33a5bbbe68d79fb7efc/plone.supermodel-1.3.3.tar.gz"; sha256 = "b7adb4603d2b0f56cf60949d09039a7964602bc83e6d8fac3a6d79212b645cc1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."lxml"
      self."plone.rfc822"
      self."z3c.zcmlhook"
      self."zope.component"
      self."zope.deferredimport"
      self."zope.dottedname"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.supermodel";
        license = licenses.bsdOriginal;
        description = "Serialize Zope schema definitions to and from XML";
      };
    };



    "plone.synchronize" = python.mkDerivation {
      name = "plone.synchronize-1.0.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/26/91/1a09c3ee8335180415509d319b289c19728c3c55705486b3942142af98b4/plone.synchronize-1.0.2.tar.gz"; sha256 = "810d0c86ae396627314f699bd3dba30ae2a6c64c50854dfed5c7db273063ea22"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.synchronize";
        license = licenses.bsdOriginal;
        description = "Simple decorators to support synchronized methods";
      };
    };



    "plone.testing" = python.mkDerivation {
      name = "plone.testing-4.1.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ed/d3/3c2d0dbb4482e3465348375e9ea15b20a9411993f8e47b1b136d0b26025c/plone.testing-4.1.2.tar.gz"; sha256 = "5a8e60a150d3494e88e608c7cd11c7da5676e6595b7fd29346af5bf0b098b04e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."Zope2"
      self."zope.component"
      self."zope.configuration"
      self."zope.event"
      self."zope.interface"
      self."zope.publisher"
      self."zope.security"
      self."zope.site"
      self."zope.testbrowser"
      self."zope.testing"
      self."zope.testrunner"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.testing";
        license = licenses.bsdOriginal;
        description = "Testing infrastructure for Zope and Plone projects.";
      };
    };



    "plone.theme" = python.mkDerivation {
      name = "plone.theme-3.0.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/26/3f/7ee03c8fe1faa8964680bb2ea24ef156c36dbd29231234ed02a4bb67ccf7/plone.theme-3.0.2.tar.gz"; sha256 = "ae29f82b05700e88b1fd5cd97d06bdeaa761dda8fa1cf48789480256de465583"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Products.CMFCore"
      self."Zope2"
      self."plone.app.testing"
      self."zope.component"
      self."zope.interface"
      self."zope.publisher"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.theme";
        license = licenses.gpl1;
        description = "Tools for managing themes in CMF and Plone sites";
      };
    };



    "plone.transformchain" = python.mkDerivation {
      name = "plone.transformchain-1.2.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ae/05/1a0c8ab59ec8be9450d461e0e75131c4b5bc59bd03e8f0642c120a397fe6/plone.transformchain-1.2.0.tar.gz"; sha256 = "8a87bfd54b8d846cd52f7c9ac9c5f64ec6596523a7548eb49e83d171bf6e1bd0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
      self."plone.testing"
      self."zope.component"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plone.transformchain";
        license = licenses.bsdOriginal;
        description = "Hook into repoze.zope2 that allows third party packages to register a sequence of hooks that will be allowed to modify the response before it is returned to the browser";
      };
    };



    "plone.uuid" = python.mkDerivation {
      name = "plone.uuid-1.0.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/61/67/e5d8f8d5c7737637ffb00df101efba3e0ab18712b06fc66b6e3640f28dd2/plone.uuid-1.0.4.tar.gz"; sha256 = "49771e3386073fac1b2bfd23c5a5f8d8065df2d6676b09a43c7143ed7f366bd4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.browserpage"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.publisher"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/plone/plone.uuid";
        license = licenses.bsdOriginal;
        description = "UUIDs for content items";
      };
    };



    "plone.z3cform" = python.mkDerivation {
      name = "plone.z3cform-0.8.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ab/c7/e7c14e16c945c5bb320bd4125a9d49defff37cbee2340aaf3cc962b0fbaa/plone.z3cform-0.8.1.zip"; sha256 = "6a133b13f82668cf866ad87b69f180812bb1b278e706d14111cbb399d5df3487"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Zope2"
      self."lxml"
      self."plone.batching"
      self."plone.testing"
      self."z3c.form"
      self."zope.browserpage"
      self."zope.component"
      self."zope.i18n"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/plone.z3cform";
        license = licenses.zpl21;
        description = "plone.z3cform is a library that allows use of z3c.form with Zope and the CMF.";
      };
    };



    "plonetheme.barceloneta" = python.mkDerivation {
      name = "plonetheme.barceloneta-1.6.23";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e6/fe/50369c2f250754bef5de0079e904401ad248aa0875544f6ed59ab1ff0bc8/plonetheme.barceloneta-1.6.23.tar.gz"; sha256 = "6c3c54ccf4e2e70c75ee5bba60b379423e6429a9b3bb4cfb49c8b5fc33b5f92e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."plone.app.theming"
      self."plone.batching"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/plonetheme.barceloneta";
        license = licenses.gpl1;
        description = "The default theme for Plone 5.";
      };
    };



    "ply" = python.mkDerivation {
      name = "ply-3.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/40/7d/95a7a67fb4c2205d0cbf89e8fabb7b49b4ed812ffdab45510d124bc2bd7e/ply-3.4.tar.gz"; sha256 = "af435f11b7bdd69da5ffbc3fecb8d70a7073ec952e101764c88720cdefb2546b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.dabeaz.com/ply/";
        license = licenses.bsdOriginal;
        description = "Python Lex & Yacc";
      };
    };



    "pycodestyle" = python.mkDerivation {
      name = "pycodestyle-2.3.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e1/88/0e2cbf412bd849ea6f1af1f97882add46a374f4ba1d2aea39353609150ad/pycodestyle-2.3.1.tar.gz"; sha256 = "682256a5b318149ca0d2a9185d365d8864a768a28db66a84a2ea946bcc426766"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pycodestyle.readthedocs.io/";
        license = licenses.mit;
        description = "Python style guide checker";
      };
    };



    "pyflakes" = python.mkDerivation {
      name = "pyflakes-1.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/26/85/f6a315cd3c1aa597fb3a04cc7d7dbea5b3cc66ea6bd13dfa0478bf4876e6/pyflakes-1.6.0.tar.gz"; sha256 = "8d616a382f243dbf19b54743f280b80198be0bca3a5396f1d2e1fca6223e8805"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/PyCQA/pyflakes";
        license = licenses.mit;
        description = "passive checker of Python programs";
      };
    };



    "python-dateutil" = python.mkDerivation {
      name = "python-dateutil-2.4.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b6/ff/5eaa688dd8ce78913f47438f9b40071a560126ac3e95f9b9be27dfe546a7/python-dateutil-2.4.2.tar.gz"; sha256 = "3e95445c1db500a344079a47b171c45ef18f57d188dffdb0e4165c71bea8eb3d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://dateutil.readthedocs.org";
        license = licenses.bsdOriginal;
        description = "Extensions to the standard Python datetime module";
      };
    };



    "python-gettext" = python.mkDerivation {
      name = "python-gettext-3.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/80/a7/a4a5cf3aa9500dbb09b48dae6d4d9581883dd90ae7a84cbb2d3448410114/python-gettext-3.0.zip"; sha256 = "f40540324edc600e33df7aaf840aec7a4021d3b0615830918c231eb1d7163456"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/python-gettext";
        license = licenses.bsdOriginal;
        description = "Python Gettext po to mo file compiler.";
      };
    };



    "python-openid" = python.mkDerivation {
      name = "python-openid-2.2.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/7b/8a/e94d18c666073280b8c0614b7e38cfaf0b129989e42f4ca713942b862f0a/python-openid-2.2.5.tar.gz"; sha256 = "92c51c3ecec846cbec4aeff11f9ff47303d4a63f93b0e6ac0ec02a091fed70ef"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/openid/python-openid";
        license = "License :: OSI Approved :: Apache Software License";
        description = "OpenID support for servers and consumers.";
      };
    };



    "pytz" = python.mkDerivation {
      name = "pytz-2016.10";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d0/e1/aca6ef73a7bd322a7fc73fd99631ee3454d4fc67dc2bee463e2adf6bb3d3/pytz-2016.10.tar.bz2"; sha256 = "7016b2c4fa075c564b81c37a252a5fccf60d8964aa31b7f5eae59aeb594ae02b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };



    "repoze.catalog" = python.mkDerivation {
      name = "repoze.catalog-0.8.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/cb/14/c0ba31d32f5c21dcc7bc807cd6690f668cb904550def2f734939658ba1b4/repoze.catalog-0.8.3.tar.gz"; sha256 = "1e1564162aca51c6cadd8b17f42272a8069b3da7b701eda0c4010da413cac927"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.component"
      self."zope.index"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.repoze.org";
        license = "BSD-derived (http://www.repoze.org/LICENSE.txt)";
        description = "Searching and indexing based on zope.index";
      };
    };



    "repoze.xmliter" = python.mkDerivation {
      name = "repoze.xmliter-0.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/bd/e4/9ce7f507d0b765b12b4407b7ae339c1534b43058f714cc4ae8bd6a7eb403/repoze.xmliter-0.6.zip"; sha256 = "f139a3ac13ec5c47528d0df5ecf2a1e6344976bb6fc22b302ebb981c2d50eadd"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."future"
      self."lxml"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.repoze.org";
        license = "BSD-derived (http://www.repoze.org/LICENSE.txt)";
        description = "Wrapper for ``lxml`` trees which serializes to string upon iteration.";
      };
    };



    "requests" = python.mkDerivation {
      name = "requests-2.9.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/64/20/2133a092a0e87d1c250fe48704974b73a1341b7e4f800edecf40462a825d/requests-2.9.2.tar.gz"; sha256 = "d8be941a08cf36e4f424ac76073eb911e5e646a33fcb3402e1642c426bf34682"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://python-requests.org";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };



    "requests-toolbelt" = python.mkDerivation {
      name = "requests-toolbelt-0.8.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/86/f9/e80fa23edca6c554f1994040064760c12b51daff54b55f9e379e899cd3d4/requests-toolbelt-0.8.0.tar.gz"; sha256 = "f6a531936c6fa4c6cfce1b9c10d5c4f498d16528d2a54a22ca00011205a187b5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://toolbelt.readthedocs.org";
        license = licenses.asl20;
        description = "A utility belt for advanced users of python-requests";
      };
    };



    "robotframework" = python.mkDerivation {
      name = "robotframework-3.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/93/15/35b58d06f35e2c12fc170c8d2aa46a8617beca52d240849388d9bf0f8386/robotframework-3.0.tar.gz"; sha256 = "cd16f5f83031b8a754ca0a7523ce10b5046a17f3b9422626804ec05b7c501c87"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://robotframework.org";
        license = licenses.asl20;
        description = "A generic test automation framework";
      };
    };



    "robotframework-debuglibrary" = python.mkDerivation {
      name = "robotframework-debuglibrary-0.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ca/38/5643a52a71bd725be0a1548d50ec531f7746b5927c4f7204206cd13b283c/robotframework-debuglibrary-0.5.tar.gz"; sha256 = "0f8173a49df7066bd95489e682566b5bab214215cfbd11577f00c57a94990abf"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."robotframework"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/xyb/robotframework-debuglibrary/";
        license = licenses.bsdOriginal;
        description = "RobotFramework debug library and an interactive shell";
      };
    };



    "robotframework-selenium2library" = python.mkDerivation {
      name = "robotframework-selenium2library-1.7.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/35/fe/6ecd8f89982cc3bb3d611182b8187dadf21af3ecbae7956a6db87f8de04f/robotframework-selenium2library-1.7.4.tar.gz"; sha256 = "4332e3021c6e4ba4a04f4dd99c4fb970315d9fc0fe31bcb62aad2fe833ad9400"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."decorator"
      self."docutils"
      self."robotframework"
      self."selenium"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/rtomac/robotframework-selenium2library";
        license = licenses.asl20;
        description = "Web testing library for Robot Framework";
      };
    };



    "robotsuite" = python.mkDerivation {
      name = "robotsuite-1.7.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/91/7a/e8dff94eb2a16f849ef5540857cedefc63d60178d0e03dfb0cfd59364e3b/robotsuite-1.7.0.tar.gz"; sha256 = "874b901bc99cf4d75219298a44c9bf658c52f434ede08531a20f396c26a9ee53"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."lxml"
      self."robotframework"
      self."six"
      self."unittest2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/collective/robotsuite/";
        license = "GPL";
        description = "Robot Framework test suite for Python unittest framework";
      };
    };



    "roman" = python.mkDerivation {
      name = "roman-1.4.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/da/21/0220fc12040847963101021cc6109a45a66ab271259c345a4cb404950a84/roman-1.4.0.tar.gz"; sha256 = "f7bf0304e2a79279cc06d245b2b7f5a3872cddbaa2932db0cbacc12a77e477ec"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/roman";
        license = licenses.psfl;
        description = "Integer to Roman numerals converter";
      };
    };



    "selenium" = python.mkDerivation {
      name = "selenium-2.53.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/41/ff/d77fd45739a2290da74ba314182fcfbe98b4e617e89b973bc5c667444334/selenium-2.53.5.tar.gz"; sha256 = "783e0064a34a026b924d0a1679d5b2ec633462e5091dd71ebd6e6d078674c597"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/SeleniumHQ/selenium/";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Python bindings for Selenium";
      };
    };



    "six" = python.mkDerivation {
      name = "six-1.11.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"; sha256 = "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/six/";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };



    "slimit" = python.mkDerivation {
      name = "slimit-0.8.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/61/cf/0d6598b1ceb463a46b75a716fbb23d2d5ccc5738aba8ddceeec3fa59997f/slimit-0.8.1.zip"; sha256 = "f433dcef899f166b207b67d91d3f7344659cb33b8259818f084167244e17720b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ply"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://slimit.readthedocs.org";
        license = licenses.mit;
        description = "SlimIt - JavaScript minifier";
      };
    };



    "sourcecodegen" = python.mkDerivation {
      name = "sourcecodegen-0.6.14";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/49/8f/2c3657f3b7dc1377510dfb7b286998c4a78ec25d84073a81c4d97b49b7e7/sourcecodegen-0.6.14.tar.gz"; sha256 = "f71971ed2d1bb188f4ca17e123bd34dca6314287726d19fc1ae5f2f0c0c6c5c3"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "BSD-like (http://repoze.org/license.html)";
        description = "A Python source-code generator based on the ``compiler.ast`` abstract syntax tree.";
      };
    };



    "tempstorage" = python.mkDerivation {
      name = "tempstorage-2.12.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/05/db/57768d06fe601210dd375ad15dc93013980cc1e4a3817f1034fd69d5a6ed/tempstorage-2.12.2.zip"; sha256 = "be5810936988f60f190dbc485134256b85f0906220a6a5be9036d94d7ebf57c4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/tempstorage";
        license = licenses.zpl21;
        description = "A RAM-based storage for ZODB";
      };
    };



    "testfixtures" = python.mkDerivation {
      name = "testfixtures-5.3.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8e/41/f3737ea2bcb357846d931750bc4ac8ad4eaa4cb81b1b5aacb480205db888/testfixtures-5.3.0.tar.gz"; sha256 = "dddaa900e518357144e837762d3ba50236745d076ec84ed2e233563c8ac9caf5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pkginfo"
      self."twine"
      self."zope.component"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Simplistix/testfixtures";
        license = licenses.mit;
        description = "A collection of helpers and mock objects for unit tests and doc tests.";
      };
    };



    "transaction" = python.mkDerivation {
      name = "transaction-1.1.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/01/95/ef0ffb1d9cd39072dc4c38ddfe181d95de696f0567eb0f862935887fd497/transaction-1.1.1.tar.gz"; sha256 = "3e00f6db97297cd2ff869b3d32109019bf898d925593926d729d546a47660ca9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.zope.org/Products/ZODB";
        license = licenses.zpl21;
        description = "Transaction management for Python";
      };
    };



    "twine" = python.mkDerivation {
      name = "twine-1.8.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e4/fc/735c94592f63ac511bd694019910bf484bb38c7ae874b2726d3aca82f897/twine-1.8.1.tar.gz"; sha256 = "68b663691a947b844f92853c992d42bb68b6333bffc9ab7f661346b001c1da82"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."clint"
      self."pkginfo"
      self."requests"
      self."requests-toolbelt"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/twine";
        license = licenses.asl20;
        description = "Collection of utilities for interacting with PyPI";
      };
    };



    "unittest2" = python.mkDerivation {
      name = "unittest2-0.5.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/86/e8/f31a7c9a3b471f6125abc8addd37c17760e00affb45d6db088394a360086/unittest2-0.5.1.tar.gz"; sha256 = "aa5de8cdf654d843379c97bd1ee240e86356d3355a97b147a6f3f4d149247a71"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/unittest2";
        license = licenses.bsdOriginal;
        description = "The new features in unittest for Python 2.7 backported to Python 2.3+.";
      };
    };



    "watchdog" = python.mkDerivation {
      name = "watchdog-0.8.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/54/7d/c7c0ad1e32b9f132075967fc353a244eb2b375a3d2f5b0ce612fd96e107e/watchdog-0.8.3.tar.gz"; sha256 = "7e65882adb7746039b6f3876ee174952f8eaaa34491ba34333ddf1fe35de4162"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."argh"
      self."pathtools"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/gorakhargosh/watchdog";
        license = licenses.asl20;
        description = "Filesystem events monitoring";
      };
    };



    "z3c.autoinclude" = python.mkDerivation {
      name = "z3c.autoinclude-0.3.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/90/12/364342fbaa9f606c3de7baa92a29d6619d794d46716125bc91118c5bb82c/z3c.autoinclude-0.3.7.tar.gz"; sha256 = "07bf6737179b562e0b8c04351afe85aeedfb521bcf7d17a6def8df20c4a4d5c9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.configuration"
      self."zope.dottedname"
      self."zope.interface"
      self."zope.schema"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/z3c.autoinclude";
        license = "ZPL";
        description = "Automatically include ZCML";
      };
    };



    "z3c.caching" = python.mkDerivation {
      name = "z3c.caching-2.0a1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fc/eb/b2e37787e674637f30fa63ca867db2568d75ad8b52c8318b7dafe3d633d0/z3c.caching-2.0a1.tar.gz"; sha256 = "ff75ba246d59227bd5d90f038dded04ac82bad4af43954994c8109d9dfb66931"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.browser"
      self."zope.component"
      self."zope.configuration"
      self."zope.event"
      self."zope.interface"
      self."zope.lifecycleevent"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.zpl21;
        description = "Caching infrastructure for web apps";
      };
    };



    "z3c.form" = python.mkDerivation {
      name = "z3c.form-3.2.11";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/26/02/56e16c4c7d8ca170e5c54623c54a9d15a7fd77f2641e6947884df9031196/z3c.form-3.2.11.tar.gz"; sha256 = "aa97a5941a3090b0974aa5228097ce252ce5f6d56753745d66235f3a8c37ad8d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."lxml"
      self."six"
      self."z3c.pt"
      self."zope.browser"
      self."zope.browserpage"
      self."zope.browserresource"
      self."zope.component"
      self."zope.configuration"
      self."zope.container"
      self."zope.contentprovider"
      self."zope.event"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.location"
      self."zope.pagetemplate"
      self."zope.publisher"
      self."zope.schema"
      self."zope.security"
      self."zope.site"
      self."zope.testing"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zopefoundation/z3c.form";
        license = licenses.zpl21;
        description = "An advanced form and widget framework for Zope 3";
      };
    };



    "z3c.formwidget.query" = python.mkDerivation {
      name = "z3c.formwidget.query-0.13";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8a/9a/d7c60f4045f2657d8591722f9665e43ef02abba4c48bae19c7dd80cabc0c/z3c.formwidget.query-0.13.tar.gz"; sha256 = "4247153164a2c0e673f431d3671fe51f560aa795271086d02e7f66eb737dfc7b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."z3c.form"
      self."zope.component"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/z3c.formwidget.query";
        license = licenses.zpl21;
        description = "A source query widget for z3c.form.";
      };
    };



    "z3c.objpath" = python.mkDerivation {
      name = "z3c.objpath-1.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ca/76/54de70f14b59c88fd83f7fd2ec2029a61673b7241c88ad313eaf4878df99/z3c.objpath-1.1.zip"; sha256 = "ed1017f59e45b03c1c05eb808312da6d999c3d7d08365bd9ef242810415499d6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.interface"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "ZPL";
        description = "Generate and resolve paths to to objects.";
      };
    };



    "z3c.pt" = python.mkDerivation {
      name = "z3c.pt-3.0.0a1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/5a/45/db9c761973f0c665e7ca093f88ff22ce1bc25d4543bb0c93caad1a350949/z3c.pt-3.0.0a1.zip"; sha256 = "c301906491f3bcb997a82d55f2481e048ebad1036fb0c19a3ff5e1f3e3f185cd"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Chameleon"
      self."six"
      self."zope.component"
      self."zope.contentprovider"
      self."zope.i18n"
      self."zope.interface"
      self."zope.testing"
      self."zope.testrunner"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/z3c.pt";
        license = licenses.zpl21;
        description = "Fast ZPT engine.";
      };
    };



    "z3c.relationfield" = python.mkDerivation {
      name = "z3c.relationfield-0.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/da/af/c474423d05d7708b65ae195406e58efd850db724f0643f3f7da219208f1d/z3c.relationfield-0.7.zip"; sha256 = "8ae295485deac495ae43a81cc23a0e89e9daa7ad00b9729457e22502960131ff"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."lxml"
      self."z3c.objpath"
      self."zc.relation"
      self."zope.container"
      self."zope.intid"
      self."zope.site"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.zpl21;
        description = "A relation field framework for Zope 3.";
      };
    };



    "z3c.zcmlhook" = python.mkDerivation {
      name = "z3c.zcmlhook-1.0b1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c5/da/cab04479eb7c64b52ff197c32bc92fb3b04d11ab1d6f818f68d7431b8524/z3c.zcmlhook-1.0b1.tar.gz"; sha256 = "f0456020738a921d68b488c453e76d7dc8b5e8c890593116854f54dfcd3c1302"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.component"
      self."zope.configuration"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.zpl21;
        description = "Easily hook into the ZCML processing machinery";
      };
    };



    "zExceptions" = python.mkDerivation {
      name = "zExceptions-2.13.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4b/86/110ab12c402082dc05cd5c121ab26d64a184477c6e3150c77edc0cfc4aef/zExceptions-2.13.0.zip"; sha256 = "66d8393f97dbbaf75f440b358cd88a413892c743866bb0b2468afb6247f9f610"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.interface"
      self."zope.publisher"
      self."zope.security"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zExceptions";
        license = licenses.zpl21;
        description = "zExceptions contains common exceptions used in Zope2.";
      };
    };



    "zLOG" = python.mkDerivation {
      name = "zLOG-2.11.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a2/ac/862d618c393546bc447ef58702cc2c26fd4a729bdcd318ca4f121efa50d2/zLOG-2.11.2.tar.gz"; sha256 = "8fa387501217cda142eaa984a43296a1f33c186ec191805ada02b99e5cbd7a25"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZConfig"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cheeseshop.python.org/pypi/zLOG";
        license = licenses.zpl21;
        description = "A general logging facility";
      };
    };



    "zc.lockfile" = python.mkDerivation {
      name = "zc.lockfile-1.0.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ed/80/412ad00eb5dc988d1b1f2307e70b3b3d9fb6cf1b0ca69fb989c8a06a558b/zc.lockfile-1.0.2.tar.gz"; sha256 = "96bb2aa0438f3e29a31e4702316f832ec1482837daef729a92e28c202d8fba5c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.python.org/pypi/zc.lockfile";
        license = licenses.zpl21;
        description = "Basic inter-process locks";
      };
    };



    "zc.recipe.testrunner" = python.mkDerivation {
      name = "zc.recipe.testrunner-1.2.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b6/ce/8f835f9c2f6164416d4eeea84eb0b98dff5d875a4838709f677242517fd9/zc.recipe.testrunner-1.2.1.tar.gz"; sha256 = "3c915dcbb1bf92986250eea99d783ff224b50a81122e7f50cee336449d8c35db"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://svn.zope.org/zc.buildout";
        license = licenses.zpl21;
        description = "ZC Buildout recipe for creating test runners";
      };
    };



    "zc.relation" = python.mkDerivation {
      name = "zc.relation-1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/bf/31/76b2c1e408136b3e61b5508d254b6ccc26c79b14dc440abe17aae05e3695/zc.relation-1.0.tar.gz"; sha256 = "771ee928bce412f4eaeb6ebebb6dbf12ca2ba9dc4d60ad0a0dae0b608b57cdc5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.interface"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "";
        description = "Index intransitive and transitive n-ary relationships.";
      };
    };



    "zdaemon" = python.mkDerivation {
      name = "zdaemon-2.0.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b6/63/09aba72e15d7eadb329e976b9b911626491093647197de6e098f2d1cd14e/zdaemon-2.0.7.tar.gz"; sha256 = "28a96152a62823052359bac7d01a375029146d31310877408bd0a91624411eb8"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZConfig"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.python.org/pypi/zdaemon";
        license = licenses.zpl21;
        description = "Daemon process control library and tools for Unix-based systems";
      };
    };



    "zest.releaser" = python.mkDerivation {
      name = "zest.releaser-6.9";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/31/79/af3eca8c06eb34edc05ecc6cca88e5824d147636919f0370272c1520ae11/zest.releaser-6.9.tar.gz"; sha256 = "06ec7a5e5a66f735b1e73bd55beee75eb323a34faddaef59a3df92a59fce237b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."check-manifest"
      self."colorama"
      self."six"
      self."twine"
      self."zope.testrunner"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://zestreleaser.readthedocs.io";
        license = licenses.gpl1;
        description = "Software releasing made easy and repeatable";
      };
    };



    "zope.annotation" = python.mkDerivation {
      name = "zope.annotation-3.5.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a1/c4/ac2a311d1f2c21f6652b7e88f809cf2c26aed04244f73b0b87e1d18bd4cc/zope.annotation-3.5.0.tar.gz"; sha256 = "2dd6752083bb2b3e597a14cf8b3ae0b0d59aa0b582d35e94b45d8f1c4bd99071"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.component"
      self."zope.interface"
      self."zope.location"
      self."zope.proxy"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.annotation";
        license = licenses.zpl21;
        description = "Object annotation mechanism";
      };
    };



    "zope.app.file" = python.mkDerivation {
      name = "zope.app.file-3.6.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8f/10/1176181e341806fcae1102ef38b010ab8399bb5d8526abe2bf32898e570c/zope.app.file-3.6.1.tar.gz"; sha256 = "aacf0c976846a4368b390ae63aecd3e2eedb6f8d6eb62ec1a07ef101aa9d0c6a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."transaction"
      self."zope.app.publication"
      self."zope.contenttype"
      self."zope.datetime"
      self."zope.dublincore"
      self."zope.event"
      self."zope.exceptions"
      self."zope.filerepresentation"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.publisher"
      self."zope.schema"
      self."zope.site"
      self."zope.size"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.app.file";
        license = licenses.zpl21;
        description = "File and Image -- Zope 3 Content Components";
      };
    };



    "zope.app.locales" = python.mkDerivation {
      name = "zope.app.locales-3.6.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/99/85/9272efb4f445ba717cc987be576b4f8962ceb5fcc8fc0570e961666dd00a/zope.app.locales-3.6.2.tar.gz"; sha256 = "45512ff909af9129f4ffd89aafb661e6369208371a2a4550ad4053425247f5cb"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.tal"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.app.locales";
        license = licenses.zpl21;
        description = "Zope locale extraction and management utilities";
      };
    };



    "zope.app.publication" = python.mkDerivation {
      name = "zope.app.publication-3.12.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/2e/15/da6cb08d5ef45ee61963c71b5a536db3de37889740db6edb4ca814d2dd17/zope.app.publication-3.12.0.zip"; sha256 = "d90f4e8244b6e62c4c2f5880885ae0115e35a583a693bd12fa8b161f9df70b16"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.annotation"
      self."zope.authentication"
      self."zope.browser"
      self."zope.browserpage"
      self."zope.component"
      self."zope.error"
      self."zope.interface"
      self."zope.location"
      self."zope.publisher"
      self."zope.security"
      self."zope.site"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.app.publication";
        license = licenses.zpl21;
        description = "Zope publication";
      };
    };



    "zope.authentication" = python.mkDerivation {
      name = "zope.authentication-3.7.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/63/c7/f89d1dc8c9956b9d7f1f4e756ab1feec0de26b1917a65181b0880a66d0d6/zope.authentication-3.7.1.zip"; sha256 = "0d4d5c7c54a7ba7bad641e9fa95ff1e0c67d91d46cb1747d64e2659343951be0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.browser"
      self."zope.component"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
      self."zope.security"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.authentication";
        license = licenses.zpl21;
        description = "Definition of authentication basics for the Zope Framework";
      };
    };



    "zope.broken" = python.mkDerivation {
      name = "zope.broken-3.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/72/ed/daa253dff16fda4420e3c6bde7e6b2e822bb5cd9869cf9e70dc7164e9a7e/zope.broken-3.6.0.zip"; sha256 = "b9b8776002da4f7b6b12dfcce77eb642ae62b39586dbf60e1d9bdc992c9f2999"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.broken";
        license = licenses.zpl21;
        description = "Zope Broken Object Interfaces";
      };
    };



    "zope.browser" = python.mkDerivation {
      name = "zope.browser-1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c0/fe/572a1ad449e12a47c74371cd33335afabe14614852c67ad6b35656cd68ec/zope.browser-1.3.zip"; sha256 = "facdabe7c0bc1c9ffe9a2e1770a2146052042529a0784a5e46cb1cc4b865bfec"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.browser";
        license = licenses.zpl21;
        description = "Shared Zope Toolkit browser components";
      };
    };



    "zope.browsermenu" = python.mkDerivation {
      name = "zope.browsermenu-3.9.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e0/cd/c8ec0f3a926a78725d88b8572073765d13748f2e5ad9541848267b8e2ebe/zope.browsermenu-3.9.1.zip"; sha256 = "900aecb2bdbfe0f2aef21892dc8bffa3220c3d5205e8e4c38e54b3f80dae083d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.browser"
      self."zope.component"
      self."zope.configuration"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.pagetemplate"
      self."zope.publisher"
      self."zope.schema"
      self."zope.security"
      self."zope.testing"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.browsermenu/";
        license = licenses.zpl21;
        description = "Browser menu implementation for Zope.";
      };
    };



    "zope.browserpage" = python.mkDerivation {
      name = "zope.browserpage-3.12.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fd/5e/5227dd366a80fd35423c7ac912432aa83ee6113c5d1550f9c81e6a9bbade/zope.browserpage-3.12.2.tar.gz"; sha256 = "b3dadfb837e0568b8be02e563c09665a25fa9054889fbe18e3f7e9fbacf508a3"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.browsermenu"
      self."zope.component"
      self."zope.configuration"
      self."zope.interface"
      self."zope.pagetemplate"
      self."zope.publisher"
      self."zope.schema"
      self."zope.security"
      self."zope.testing"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.browserpage/";
        license = licenses.zpl21;
        description = "ZCML directives for configuring browser views for Zope.";
      };
    };



    "zope.browserresource" = python.mkDerivation {
      name = "zope.browserresource-3.10.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a8/ef/046788dbb93edd2823780405d913c9ba33b9bd56519fe95132bdaeeaec32/zope.browserresource-3.10.3.zip"; sha256 = "95ca1648ab53b43e9c1d728e075e7fdc4ec3e7533c00cf21b6c28bf43011112f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.component"
      self."zope.configuration"
      self."zope.contenttype"
      self."zope.i18n"
      self."zope.interface"
      self."zope.location"
      self."zope.publisher"
      self."zope.schema"
      self."zope.testing"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.browserresource/";
        license = licenses.zpl21;
        description = "Browser resources implementation for Zope.";
      };
    };



    "zope.cachedescriptors" = python.mkDerivation {
      name = "zope.cachedescriptors-3.5.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b8/8a/b54eb8dea20aa3b7e55b186f43d50953a514c3e362c06e71d3005be11a5c/zope.cachedescriptors-3.5.1.zip"; sha256 = "6a37062ce6b17029521155d3301a3df2bf05ebd6a8ee0477a031435a4a2af3d0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.cachedescriptors";
        license = licenses.zpl21;
        description = "Method and property caching decorators";
      };
    };



    "zope.component" = python.mkDerivation {
      name = "zope.component-3.9.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f0/c4/960684a757e404fd935ca581221016a7a7e5cd96965bb32348d586039060/zope.component-3.9.5.tar.gz"; sha256 = "7664890ede99d30342f05a14251e0d3e2e264232a30b7310769e22d5a29a989a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.configuration"
      self."zope.event"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.location"
      self."zope.proxy"
      self."zope.security"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.component";
        license = licenses.zpl21;
        description = "Zope Component Architecture";
      };
    };



    "zope.componentvocabulary" = python.mkDerivation {
      name = "zope.componentvocabulary-1.0.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/91/ed/289e50085cccf60342dca1d747fdbc2eea2b4b5a3cc3fa5843fbb27e88fb/zope.componentvocabulary-1.0.1.tar.gz"; sha256 = "07899d971e97f51be31b49c35b6c2d812cafc8d53ce130e5bd08662d50444829"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.component"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
      self."zope.security"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.componentvocabulary";
        license = licenses.zpl21;
        description = "Component vocabularies";
      };
    };



    "zope.configuration" = python.mkDerivation {
      name = "zope.configuration-3.7.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a7/16/32f278e57310fd167926f0297ec0e24fd66cc7e6b04fd1c853e282a07a5e/zope.configuration-3.7.4.zip"; sha256 = "1cb7e757ee282fe25eecaf9bf6a5e8715025bc7c6c4374a996879cd5a24c9249"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.configuration";
        license = licenses.zpl21;
        description = "Zope Configuration Markup Language (ZCML)";
      };
    };



    "zope.container" = python.mkDerivation {
      name = "zope.container-3.11.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/5a/c9/303be404bbc3cb93bb47492238bacb0d020b90d62758f0b1ca9411c97d33/zope.container-3.11.2.tar.gz"; sha256 = "87a6f526e8f4ad34ad2b768b9887b67185d0d993daa428c20452ee044600c7c5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.broken"
      self."zope.component"
      self."zope.configuration"
      self."zope.dottedname"
      self."zope.event"
      self."zope.filerepresentation"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.location"
      self."zope.publisher"
      self."zope.schema"
      self."zope.security"
      self."zope.size"
      self."zope.testing"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.container";
        license = licenses.zpl21;
        description = "Zope Container";
      };
    };



    "zope.contentprovider" = python.mkDerivation {
      name = "zope.contentprovider-3.7.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ec/e1/0e7f0cdf92b5824617732371a1a6a0969f1a53fcfebdc6ae29f48cd2176d/zope.contentprovider-3.7.2.tar.gz"; sha256 = "672fbb3922974b1c23bad605e020c10ff5ca31c44abf45ac9cd08cbbecab3432"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.browserpage"
      self."zope.component"
      self."zope.event"
      self."zope.interface"
      self."zope.location"
      self."zope.publisher"
      self."zope.schema"
      self."zope.tales"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.contentprovider";
        license = licenses.zpl21;
        description = "Content Provider Framework for Zope Templates";
      };
    };



    "zope.contenttype" = python.mkDerivation {
      name = "zope.contenttype-3.5.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/43/ab/a26760e188b3d172aee9a23df5e728f35f8d260485452aa8a4d06611d1da/zope.contenttype-3.5.5.zip"; sha256 = "4ccb6f0952ac533a70f11521dbc2df34164fb00ecab746130a625de7cc9b47f7"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.contenttype";
        license = licenses.zpl21;
        description = "Zope contenttype";
      };
    };



    "zope.copy" = python.mkDerivation {
      name = "zope.copy-3.5.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/91/f3/b5d73aef4684868cf1561a365fd6a612a06b1225ab9825fe577ca0dcdcdb/zope.copy-3.5.0.tar.gz"; sha256 = "2e95fa032946898a6e689bc48fa3444b0be1861c11545bf710431d8f9195a7fd"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.component"
      self."zope.interface"
      self."zope.location"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.copy";
        license = licenses.zpl21;
        description = "Pluggable object copying mechanism";
      };
    };



    "zope.datetime" = python.mkDerivation {
      name = "zope.datetime-3.4.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/78/73/9dc0ae29ef7caf8a5058eb1c5c2a1592172d99325f81c906627b5f3d6256/zope.datetime-3.4.1.tar.gz"; sha256 = "373b8ed926ba18e2cf17e72011f7cecb0c4c35bbd0ede6cc0426e2e6e9b9c5b2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.datetime";
        license = licenses.zpl21;
        description = "Zope datetime";
      };
    };



    "zope.deferredimport" = python.mkDerivation {
      name = "zope.deferredimport-3.5.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b7/c3/e31c4b25b9db8d5b7f0da330082b8e6262749315621c2766097a5da76fb9/zope.deferredimport-3.5.3.tar.gz"; sha256 = "eddece4118a7caf035700b070fed22b04d33c4b8fc2b5fdc9eda77d83cdb4877"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.proxy"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.deferredimport";
        license = licenses.zpl21;
        description = "zope.deferredimport allows you to perform imports names that will only be resolved when used in the code.";
      };
    };



    "zope.deprecation" = python.mkDerivation {
      name = "zope.deprecation-3.4.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/73/04/af94cc85f00bcbd11d1c3a6667fa6cbfb8325587fc44094511d8b8a9da50/zope.deprecation-3.4.1.tar.gz"; sha256 = "1a4df823ae1cce7222bd7e89ba5ae9b5391d488fdc114353a4178642665acc4c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.deprecation";
        license = licenses.zpl21;
        description = "Zope Deprecation Infrastructure";
      };
    };



    "zope.dottedname" = python.mkDerivation {
      name = "zope.dottedname-3.4.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/92/66/c7a200fa1481b32a73c612f20e911a0646e2a993e4040580d4c320a2493e/zope.dottedname-3.4.6.tar.gz"; sha256 = "331d801d98e539fa6c5d50c3835ecc144c429667f483281505de53fc771e6bf5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.dottedname";
        license = licenses.zpl21;
        description = "Resolver for Python dotted names.";
      };
    };



    "zope.dublincore" = python.mkDerivation {
      name = "zope.dublincore-3.7.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/5c/a7/81a6fcdabddd9d18f6a641742987a081f0d8f199ba9cb595f94752ef2ed3/zope.dublincore-3.7.0.tar.gz"; sha256 = "42465c5b31d8710015e84445a85bb5848f17ddc666aca87b179176938d8d41fe"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytz"
      self."zope.annotation"
      self."zope.component"
      self."zope.datetime"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.location"
      self."zope.schema"
      self."zope.security"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.dublincore";
        license = licenses.zpl21;
        description = "Zope Dublin Core implementation";
      };
    };



    "zope.error" = python.mkDerivation {
      name = "zope.error-3.7.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/71/ff/3cee25c2badaf32bba893514538a063b4b712a5a3a22bb417f180ef50dd1/zope.error-3.7.4.tar.gz"; sha256 = "9e22106c88bdf1c7ebafb96eddf7bd2207db8994edde6b1de7e7dafa16cd080e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.exceptions"
      self."zope.interface"
      self."zope.location"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.error";
        license = licenses.zpl21;
        description = "An error reporting utility for Zope3";
      };
    };



    "zope.event" = python.mkDerivation {
      name = "zope.event-3.5.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ad/73/ace089bcd93f9a4a740cc1a80307e42dac10f5b92e044e470d524caf154f/zope.event-3.5.2.tar.gz"; sha256 = "fe543e107340e4158293928fd2723d3634dd0fc212519c9d0f5d0a8012a79e39"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.event";
        license = licenses.zpl21;
        description = "Very basic event publishing system";
      };
    };



    "zope.exceptions" = python.mkDerivation {
      name = "zope.exceptions-3.6.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/01/03/3f240e293811e547b1adb6e2f3e3ad1412a6a125abaef21a517172e68595/zope.exceptions-3.6.2.tar.gz"; sha256 = "ba8618991341ead4b726bf7b8b9e5bbb47018f29c9923412c272b27e440c6ac5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cheeseshop.python.org/pypi/zope.exceptions";
        license = licenses.zpl21;
        description = "Zope Exceptions";
      };
    };



    "zope.filerepresentation" = python.mkDerivation {
      name = "zope.filerepresentation-3.6.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/2b/6d/ae0d3523e3ee856c5ecea88be19acf34ae10afb5d47c477188f9ab26384e/zope.filerepresentation-3.6.1.tar.gz"; sha256 = "d775ebba4aff7687e0381f050ebda4e48ce50900c1438f3f7e901220634ed3e0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.filerepresentation";
        license = licenses.zpl21;
        description = "File-system Representation Interfaces";
      };
    };



    "zope.formlib" = python.mkDerivation {
      name = "zope.formlib-4.0.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d3/72/417e1df7122d10c8694a4f67549bba55b74d6ffca3942c737118c890bbe6/zope.formlib-4.0.6.zip"; sha256 = "eccca7a4fa967f4a37570230d6d83faaf3cba5f6a046610848d0b7f10ee625e8"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytz"
      self."zope.browser"
      self."zope.browserpage"
      self."zope.component"
      self."zope.configuration"
      self."zope.datetime"
      self."zope.event"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.publisher"
      self."zope.schema"
      self."zope.security"
      self."zope.testing"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.formlib";
        license = licenses.zpl21;
        description = "Form generation and validation library for Zope";
      };
    };



    "zope.globalrequest" = python.mkDerivation {
      name = "zope.globalrequest-1.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/98/8f/c1071a46c82540d8c47511082e1052ceecf06f309b7f4b2dce8c0aeb3027/zope.globalrequest-1.2.tar.gz"; sha256 = "d79eea413b77dceaa29a602852e5092b62a7035e0e7c0898a7bd9429023598ca"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.configuration"
      self."zope.interface"
      self."zope.publisher"
      self."zope.testbrowser"
      self."zope.testing"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pypi.python.org/pypi/zope.globalrequest";
        license = licenses.zpl21;
        description = "Global way of retrieving the currently active request.";
      };
    };



    "zope.i18n" = python.mkDerivation {
      name = "zope.i18n-3.7.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/db/5e/1d77d3b10c69781ca6c316645d7cf189b0e88e85cf8e0e273add0b9f2918/zope.i18n-3.7.4.tar.gz"; sha256 = "ed7f54c2be978d28b62cfebf54a74cf4e785500c33d5c0d396ff662fb9e0747c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."python-gettext"
      self."pytz"
      self."zope.component"
      self."zope.configuration"
      self."zope.i18nmessageid"
      self."zope.schema"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.i18n";
        license = licenses.zpl21;
        description = "Zope Internationalization Support";
      };
    };



    "zope.i18nmessageid" = python.mkDerivation {
      name = "zope.i18nmessageid-3.5.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1e/cb/3478d8ce7683d359dfdeedba289d05aec1418940136ed32f4c2b4e368793/zope.i18nmessageid-3.5.3.tar.gz"; sha256 = "7f423e40969de31ad9b93e7e0241ff1d9d9e02ff15c3309fa9fa69daedd9c71b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.i18nmessageid";
        license = licenses.zpl21;
        description = "Message Identifiers for internationalization";
      };
    };



    "zope.index" = python.mkDerivation {
      name = "zope.index-3.6.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fc/86/884c279aad3b95c61ae50f9df67e8f0e44ab45f6665baf812ff0ffc1300a/zope.index-3.6.4.tar.gz"; sha256 = "e87788e9639dc98c271b31e3afb5a1dde06daacdcd3ae7ab51aad1ff57c559d2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.index";
        license = licenses.zpl21;
        description = "Indices for using with catalog like text, field, etc.";
      };
    };



    "zope.interface" = python.mkDerivation {
      name = "zope.interface-3.6.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b1/e9/920728241c8cc0b0715fdb25cdc7adcca99c2f85b84597fefa383b7e4b73/zope.interface-3.6.7.zip"; sha256 = "85ac373828528ea18a3388cb9b5227b85fd3c3cc99f9875cf89cfea86134ffdc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.interface";
        license = licenses.zpl21;
        description = "Interfaces for Python";
      };
    };



    "zope.intid" = python.mkDerivation {
      name = "zope.intid-3.7.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/08/43/6db1c35955c31547d22e3cbae7cda41eaba19c2ae9e80b1a785c9732d674/zope.intid-3.7.2.zip"; sha256 = "4407b15fba8c332bec899ad70da75fd077c9efff8441aac50c03f0eb5ac1e098"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.component"
      self."zope.container"
      self."zope.event"
      self."zope.interface"
      self."zope.keyreference"
      self."zope.lifecycleevent"
      self."zope.location"
      self."zope.security"
      self."zope.site"
      self."zope.testing"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.intid";
        license = licenses.zpl21;
        description = "Integer Id Utility";
      };
    };



    "zope.keyreference" = python.mkDerivation {
      name = "zope.keyreference-3.6.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/7b/1a/ca9335023253a369cfd3334dfaa43e96e57f1c065d5c4d429f1baa1a830d/zope.keyreference-3.6.4.tar.gz"; sha256 = "8cd20b29e3e9ff5ab78212470d87585358c14f08cdfbd153cfb50bbeba8335fc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.component"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.keyreference";
        license = licenses.zpl21;
        description = "Key References";
      };
    };



    "zope.lifecycleevent" = python.mkDerivation {
      name = "zope.lifecycleevent-3.6.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/69/b0/9ecd00a9aafeff81d2adf72c7f99d8a56c1c6882d3853d897d19b6567f19/zope.lifecycleevent-3.6.2.tar.gz"; sha256 = "cdea5cbf059a8b01ff744b625e78f60b2c4ea0b9fb908407973bcee84b446ec4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.component"
      self."zope.container"
      self."zope.event"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.lifecycleevent";
        license = licenses.zpl21;
        description = "Object life-cycle events";
      };
    };



    "zope.location" = python.mkDerivation {
      name = "zope.location-3.9.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b8/2a/7e46cb02ffafb4dee35ee5e598550013698d43b2aa87ba95b2789328e51d/zope.location-3.9.1.tar.gz"; sha256 = "cec909f57def8005973ebff0deada11d2fc25438da34d691a2417eaca2966116"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.component"
      self."zope.configuration"
      self."zope.interface"
      self."zope.proxy"
      self."zope.schema"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.location/";
        license = licenses.zpl21;
        description = "Zope Location";
      };
    };



    "zope.pagetemplate" = python.mkDerivation {
      name = "zope.pagetemplate-3.6.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f7/b5/98706cc95df06c8a1f3c93f0319eea56c31f92031413896443d72ef3a8f4/zope.pagetemplate-3.6.3.zip"; sha256 = "0851b1b7b1c873bb567454ca2567075db40b0800ba8637e8e54525747d0aef7f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.component"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.proxy"
      self."zope.security"
      self."zope.tal"
      self."zope.tales"
      self."zope.testing"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.pagetemplate";
        license = licenses.zpl21;
        description = "Zope Page Templates";
      };
    };



    "zope.processlifetime" = python.mkDerivation {
      name = "zope.processlifetime-1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/80/dd/e66f1ddd36c8bf14312c3a67d6292ba662712093927c4904ac578b41261f/zope.processlifetime-1.0.tar.gz"; sha256 = "acc3aa2e02bad02e69948a00f92947bb68d6c9d875b32d289cf0832d37050d08"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.processlifetime";
        license = licenses.zpl21;
        description = "Zope process lifetime events";
      };
    };



    "zope.proxy" = python.mkDerivation {
      name = "zope.proxy-3.6.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/68/24/6cc2a4e89594cf91e5a3641015be884d2c3d8af2ae4b8445939dcc1466b8/zope.proxy-3.6.1.zip"; sha256 = "3d1c8ccd2154e96bda5ef305997fcb2a90f7b79b43f70b85ee3a3287ac708e11"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.proxy";
        license = licenses.zpl21;
        description = "Generic Transparent Proxies";
      };
    };



    "zope.ptresource" = python.mkDerivation {
      name = "zope.ptresource-3.9.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/dd/34/f39379faab73f2a8330d0413b5b38402b6af8dbe77ed34c2fb6e1289507d/zope.ptresource-3.9.0.tar.gz"; sha256 = "63f72d82e21a816f51af70a813ba9a6f7c7fcd214944e413b387bcb711500116"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.browserresource"
      self."zope.interface"
      self."zope.pagetemplate"
      self."zope.publisher"
      self."zope.security"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.ptresource/";
        license = licenses.zpl21;
        description = "Page template resource plugin for zope.browserresource";
      };
    };



    "zope.publisher" = python.mkDerivation {
      name = "zope.publisher-3.12.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/81/44/cdf057b23bd5077323eb095cc9d13dacdee2478a1027346fcefe50909fee/zope.publisher-3.12.6.tar.gz"; sha256 = "d994d8eddfba504841492115032a9a7d86b1713ebc96d0ca16fbc6ee93168ba4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.browser"
      self."zope.component"
      self."zope.configuration"
      self."zope.contenttype"
      self."zope.event"
      self."zope.exceptions"
      self."zope.i18n"
      self."zope.interface"
      self."zope.location"
      self."zope.proxy"
      self."zope.security"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.publisher";
        license = licenses.zpl21;
        description = "The Zope publisher publishes Python objects on the web.";
      };
    };



    "zope.ramcache" = python.mkDerivation {
      name = "zope.ramcache-1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b8/86/3a8193ca2525a47610cbbb0f1c08dbf7f654898ffcc06816991b50c1b0c0/zope.ramcache-1.0.zip"; sha256 = "60d87dd2bcc287ddd2dc3b1e4a22b450ea76b724bdbf6fa18968b9aace2efd60"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.interface"
      self."zope.location"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.ramcache";
        license = licenses.zpl21;
        description = "Zope RAM Cache";
      };
    };



    "zope.schema" = python.mkDerivation {
      name = "zope.schema-4.4.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/0d/b2/41fdc6c42c4320f326c65810eff785247e65e4ea856cff15120e47b93509/zope.schema-4.4.2.tar.gz"; sha256 = "d32a089d2a774fe67fd19864780e12ebd88d09e89b5c780f6c0795d59b1c24dd"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.event"
      self."zope.interface"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.schema";
        license = licenses.zpl21;
        description = "zope.interface extension for defining data schemas";
      };
    };



    "zope.security" = python.mkDerivation {
      name = "zope.security-3.7.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/33/31/cec2173af37cce82968dfefdfc7e69a1c42320054b0b901f5e0bcc0d621b/zope.security-3.7.4.tar.gz"; sha256 = "b645dbca52320270f51343b86339e6c20d0474ea5e1834063bafcc433f8a2810"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."RestrictedPython"
      self."pytz"
      self."zope.component"
      self."zope.configuration"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.location"
      self."zope.proxy"
      self."zope.schema"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.security";
        license = licenses.zpl21;
        description = "Zope Security Framework";
      };
    };



    "zope.sendmail" = python.mkDerivation {
      name = "zope.sendmail-3.7.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/86/7e/a88c12398c13dbddb94345e836753cbc4d8f04a6ebaa65ed791aaf16338b/zope.sendmail-3.7.5.tar.gz"; sha256 = "77ff918ff37d0ca80dcae9739617943f0330e7e3b9519ce0d3097acd80357df5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."transaction"
      self."zope.component"
      self."zope.configuration"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.schema"
      self."zope.security"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.sendmail";
        license = licenses.zpl21;
        description = "Zope sendmail";
      };
    };



    "zope.sequencesort" = python.mkDerivation {
      name = "zope.sequencesort-3.4.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/3f/85/3c36603116b2420509dfe49a942d2086461e580a99f32ce2b94b95987c24/zope.sequencesort-3.4.0.tar.gz"; sha256 = "a77481947d348f02c59c935bc4d390e29fbb4333b39641e6a6262baf53bd9395"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cheeseshop.python.org/pypi/zope.sequencesort";
        license = licenses.zpl21;
        description = "Sequence Sorting";
      };
    };



    "zope.site" = python.mkDerivation {
      name = "zope.site-3.9.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/80/49/e56a008ab36a518e4f89812a3f83aa192cb22d24b005f10a32ed1cc8faa0/zope.site-3.9.2.tar.gz"; sha256 = "95f6c23d1c19511308ebc841a4dda37ef6f1eb5c4d2624db4216d4640013e647"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.annotation"
      self."zope.component"
      self."zope.configuration"
      self."zope.container"
      self."zope.event"
      self."zope.interface"
      self."zope.lifecycleevent"
      self."zope.location"
      self."zope.security"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.site";
        license = licenses.zpl21;
        description = "Local registries for zope component architecture";
      };
    };



    "zope.size" = python.mkDerivation {
      name = "zope.size-3.4.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b6/5a/763b705b863b1e8c486f13d583c98e3ffeed40bbf650ba795a4ffee251f5/zope.size-3.4.1.tar.gz"; sha256 = "6f1d53becc0dcc10ab9670f61c1086c91a5c0edcfab2afe764cc29d6f1234578"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.i18nmessageid"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.size";
        license = licenses.zpl21;
        description = "Interfaces and simple adapter that give the size of an object";
      };
    };



    "zope.structuredtext" = python.mkDerivation {
      name = "zope.structuredtext-3.5.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/66/75/cc29dadae3d65c7e5012f928d786ec9ea6bbb1abb54f76899d0a6bb1a259/zope.structuredtext-3.5.1.tar.gz"; sha256 = "12b9119ccc737470da73ee777118068db171e77ef9f28e69360905da8b8dbc70"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.structuredtext";
        license = licenses.zpl21;
        description = "StructuredText parser";
      };
    };



    "zope.tal" = python.mkDerivation {
      name = "zope.tal-3.5.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ff/f3/2d99f67be0732cbb49627fcec565890bd9a53bd5fbcea35a75321190e46c/zope.tal-3.5.2.zip"; sha256 = "dab6ed841046382c1fb39c543ffd09cbd152593b7cbdf5a67970b2a805c5feba"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.tal";
        license = licenses.zpl21;
        description = "Zope 3 Template Application Languate (TAL)";
      };
    };



    "zope.tales" = python.mkDerivation {
      name = "zope.tales-3.5.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/12/d4/eb536d79316dc266f3651e10d6e0232100576d3c7e71f90b5f44cd5a052a/zope.tales-3.5.3.tar.gz"; sha256 = "6270f6f87f2b0442a8397dd5a2649c1e85aa65f03f0b1e156b90fbe270601426"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.interface"
      self."zope.tal"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.tales";
        license = licenses.zpl21;
        description = "Zope Template Application Language Expression Syntax (TALES)";
      };
    };



    "zope.testbrowser" = python.mkDerivation {
      name = "zope.testbrowser-3.11.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/21/96/6cee0b50c06854df241165bb078e146a175f67b9f2c1d33eea563740ea81/zope.testbrowser-3.11.1.tar.gz"; sha256 = "7744def512b47447ef5c17c329537c906243d9c58242d678a2ea370e9f930298"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."mechanize"
      self."pytz"
      self."zope.app.publication"
      self."zope.browserpage"
      self."zope.browserresource"
      self."zope.component"
      self."zope.container"
      self."zope.interface"
      self."zope.ptresource"
      self."zope.publisher"
      self."zope.schema"
      self."zope.security"
      self."zope.site"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.testbrowser";
        license = licenses.zpl21;
        description = "Programmable browser for functional black-box tests";
      };
    };



    "zope.testing" = python.mkDerivation {
      name = "zope.testing-3.9.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/cb/ad/92bef28619122440619d8ff1462b3c4fcb028522e4c072a26743394ee26e/zope.testing-3.9.7.tar.gz"; sha256 = "80d6a5327dc382b6a9791c0ed2953f37b67a2c18dcc941a292d678fc07d77364"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.exceptions"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.testing";
        license = licenses.zpl21;
        description = "Zope testing framework, including the testrunner script.";
      };
    };



    "zope.testrunner" = python.mkDerivation {
      name = "zope.testrunner-4.4.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e9/d4/f8383c3bb4798abf4a4fbe0eb89f39798eb65b46837667f093936ed8c977/zope.testrunner-4.4.4.zip"; sha256 = "4708b539389fb48197c9e28f9f3f661c4cb7fc8f3ea4cd77882e0825eebda2cf"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
      self."zope.exceptions"
      self."zope.interface"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.testrunner";
        license = licenses.zpl21;
        description = "Zope testrunner script.";
      };
    };



    "zope.traversing" = python.mkDerivation {
      name = "zope.traversing-3.13.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f9/27/6cccc983aa7479bbfb730ae3410e64d712810d7d58fc971d268c00b0fad0/zope.traversing-3.13.2.zip"; sha256 = "5a340a410ac347f1da56b64e8faeb200c6a21068d301f72ba65131521b5e89c9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."ZODB3"
      self."zope.browserpage"
      self."zope.browserresource"
      self."zope.component"
      self."zope.configuration"
      self."zope.container"
      self."zope.i18n"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.location"
      self."zope.pagetemplate"
      self."zope.proxy"
      self."zope.publisher"
      self."zope.security"
      self."zope.site"
      self."zope.tal"
      self."zope.testing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.traversing";
        license = licenses.zpl21;
        description = "Resolving paths in the object hierarchy";
      };
    };



    "zope.viewlet" = python.mkDerivation {
      name = "zope.viewlet-3.7.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8a/d4/3a466dbe7b7ac67e481b155addfc1ce8534417942b7da2ed7afec1cbcb9f/zope.viewlet-3.7.2.tar.gz"; sha256 = "4fe3d24f9cc7a70f4e774b923df6688538ff2164cde34f74981ed773ef60b2d7"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.browserpage"
      self."zope.component"
      self."zope.configuration"
      self."zope.contentprovider"
      self."zope.event"
      self."zope.i18nmessageid"
      self."zope.interface"
      self."zope.location"
      self."zope.publisher"
      self."zope.schema"
      self."zope.security"
      self."zope.size"
      self."zope.testing"
      self."zope.traversing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.viewlet";
        license = licenses.zpl21;
        description = "Zope Viewlets";
      };
    };

  };
  localOverridesFile = ./requirements_override.nix;
  overrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [

  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [overrides] else [] ) ++ commonOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )