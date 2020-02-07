# bin

## MArchiveBatchTool

The precompiled binary files provided were compiled on Fedora 31 on an x86-64.
The build script used was:

```sh
$ sudo dnf -y copr enable @dotnet-sig/dotnet
$ sudo dnf -y install dotnet-sdk-3.0
$ git clone https://gitlab.com/modmyclassic/sega-mega-drive-mini/marchive-batch-tool.git
$ cd marchive-batch-tool
$ git checkout 1f6b03ac8c91780735e35e123a6527962ea72162
$ dotnet publish -c Release -r linux-x64 --self-contained true MArchiveBatchTool.sln
```

The resulting binaries will be in `MArchiveBatchTool/bin/Release/netcoreapp2.2/linux-x64/publish`.
