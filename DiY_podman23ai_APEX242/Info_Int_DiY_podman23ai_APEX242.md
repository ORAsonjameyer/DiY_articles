# Installation script for podman envwith 23ai latest and APEX latest with ORDS latest

## 23ai latest

(base) SOMEYER@SOMEYER-mac ~ % pwd
/Users/SOMEYER
(base) SOMEYER@SOMEYER-mac ~ % cd dev/podman 
(base) SOMEYER@SOMEYER-mac podman % podman pull ghcr.io/gvenzl/oracle-free:full-faststart
Trying to pull ghcr.io/gvenzl/oracle-free:full-faststart...
Getting image source signatures
Copying blob sha256:60b642b37260b77fa17983e24ac98dee4886b1c2481a6328f370c9dfe38d89b3
Copying blob sha256:03f3109bffdb8161ffa890c8de4dbf065fa8d54112f338a3d5de7d6bcbf0fda1
Copying blob sha256:b53bd38caf1cf15479d41096fb3b394cffc7bdd84b1ecd3192e2171b3c0c0da8
Copying blob sha256:9941295a2fb8f6cc0f06e3414b7c68b63294687c0b6c4d914fc32b8677155815
Copying blob sha256:adea4aa8aaedfe6e51efe4105a09e4ef2fa639be1db288bd787d922221d5de96
Copying blob sha256:700f4c74457ebca05868dc712165f79c1aca60f89b8bba7697cbbc36ed6cc1e9
Copying blob sha256:0147761b496443edc93702cf686a0ab5633a03ee41f6c984ee68521094e1e0ea
Copying blob sha256:d2e85e63b3a9c11b8fcd30de8219566dd9096c043328ee7f25b58afbbefeddd8
Copying blob sha256:0e29b1364903dcfba30156ef5a3a1c46aea675d737e360fa6e918eea23fb5b0b
Copying config sha256:c24b8971c1302c31bf40e8eec5b48c40bf4b7896187296ed70a11ea048853017
Writing manifest to image destination
c24b8971c1302c31bf40e8eec5b48c40bf4b7896187296ed70a11ea048853017


## ORDS latest 
(base) SOMEYER@SOMEYER-mac podman % podman pull container-registry.oracle.com/database/ords:25.2.0
Trying to pull container-registry.oracle.com/database/ords:25.2.0...
Getting image source signatures
Copying blob sha256:4f4fb700ef54461cfa02571ae0db9a0dc1e0cdb5577484a6d75e68dc38e8acc1
Copying blob sha256:d10a42b6f3f97171f3bded6edac0e8396d7f5227e1628c09f2e8e6e41838462a
Copying blob sha256:64288cf9cda46e9547fcd3c2060624916766ac0a7afbe31ba7ea883202733311
Copying blob sha256:6eb2d6e8e61cc33aeab5ce85eac069641cd282bfedd08e8c7d1e6254d9e28a8d
Copying blob sha256:720b16868171fb6ff30f1b397bfe33125340c47a7b069c75f0ca2d7b095e7db2
Copying blob sha256:6bf43ed45ac2c1417cb77544c710bd69d5e2598659668a692a90be88f64059ab
Copying config sha256:2093409e70875d8512e3eb3884b465d64151c8462edef6c86e4bb42ac7f9ded3
Writing manifest to image destination
2093409e70875d8512e3eb3884b465d64151c8462edef6c86e4bb42ac7f9ded3


## create Podman Secret 
(base) SOMEYER@SOMEYER-mac DiY_sqlcl_project % echo -n 'Oracle!APEX2025' | podman secret create oracle_dba_pwd -
6146935b2edf6ec499ea456b9


## start podman-compose env 
(base) SOMEYER@SOMEYER-mac apex % pwd
/Users/SOMEYER/dev/apex
(base) SOMEYER@SOMEYER-mac apex % ls -rtl
total 16
drwxr-xr-x  2 SOMEYER  staff    64 Mar 31 16:21 setup
-rw-r--r--  1 SOMEYER  staff  1036 Apr 19 18:02 compose_242.yml
-rw-r--r--  1 SOMEYER  staff  1017 Jul 22 15:56 compose.yml
(base) SOMEYER@SOMEYER-mac apex % podman-compose up -d
3f0038efa65c85e679cc60d2f8f1d777c770cce9575ac1effe8faf4e63e24a9b
Trying to pull ghcr.io/gvenzl/oracle-free:latest...
Getting image source signatures
Copying blob sha256:ae63616e9bb8a98c44c47c2ae51c9f874b83bcc2905cdbd850c8f1b28184eb7b
Copying blob sha256:e861ad8901d3c5d3177e448bcf004602eed373ec13076689a515c5d704f57a8f
Copying blob sha256:9f76ce5b7c4e6f887b88e3290f8edbdea7416fbf79ac0b6a399c40d3fb84f91d
Copying blob sha256:b1dd98e90bd7445ae8739f9745a371101f756aad4f09420881793e7120e15b42
Copying blob sha256:248fca0fba7c29772f144f49e14b7c86d2805044ea926f24a0cfed63f22fc751
Copying blob sha256:bb2390c1a0ef22f3edfe52837f647c1f5e6c1ec98441308770c36c3f98c9d350
Copying config sha256:4d9f27ac0289f6a5a53e75401ab417a5b89745329e8f72ee8e5c679763f3164e
Writing manifest to image destination
cfdb65943442439fa94f834cfd795680c3a69ce6ad31c4d998a06b0cf51e65ab
Trying to pull container-registry.oracle.com/database/ords:latest...
Getting image source signatures
Copying blob sha256:4f4fb700ef54461cfa02571ae0db9a0dc1e0cdb5577484a6d75e68dc38e8acc1
Copying blob sha256:d10a42b6f3f97171f3bded6edac0e8396d7f5227e1628c09f2e8e6e41838462a
Copying blob sha256:64288cf9cda46e9547fcd3c2060624916766ac0a7afbe31ba7ea883202733311
Copying blob sha256:6eb2d6e8e61cc33aeab5ce85eac069641cd282bfedd08e8c7d1e6254d9e28a8d
Copying blob sha256:720b16868171fb6ff30f1b397bfe33125340c47a7b069c75f0ca2d7b095e7db2
Copying blob sha256:6bf43ed45ac2c1417cb77544c710bd69d5e2598659668a692a90be88f64059ab
Copying config sha256:2093409e70875d8512e3eb3884b465d64151c8462edef6c86e4bb42ac7f9ded3
Writing manifest to image destination
25eaed98191ad4f68deafb85a4ffefbd21b570872d86b160afcab4bf05126346
apex_oraclefree_1
apex_ords_1

## create secret password
(base) SOMEYER@SOMEYER-mac DiY_sqlcl_project % echo -n 'Oracle!APEX2025' | podman secret create oracle_dba_pwd -
6146935b2edf6ec499ea456b9

## create conn_string.txt to save "CONN_STRING=sys/Oracle!APEX2025@apex_oraclefree_1:1521/freepdb1"
(base) SOMEYER@SOMEYER-mac ~ % cd dev/apex/setup 
echo 'CONN_STRING=sys/Oracle!APEX2025@apex_oraclefree_1:1521/freepdb1' > setup/conn_string.txt