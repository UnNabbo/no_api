@echo off

jai first.jai - %*
pushd examples
..\cshader.bat compute.slang -o compute.spv
..\cshader.bat shader.slang -o shader.spv
popd


