@echo off

jai first.jai - %*
pushd examples
..\cshader.bat shader.slang -o shader.spv
..\cshader.bat compute.slang -o compute.spv
popd


