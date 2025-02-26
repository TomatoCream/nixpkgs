{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  hatchling,

  # dependencies
  anyio,
  pycrdt,
  sqlite-anyio,

  # optional-dependencies
  channels,

  # tests
  httpx-ws,
  hypercorn,
  pytest-asyncio,
  pytestCheckHook,
  trio,
  uvicorn,
  websockets,
}:

buildPythonPackage rec {
  pname = "pycrdt-websocket";
  version = "0.15.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "jupyter-server";
    repo = "pycrdt-websocket";
    tag = "v${version}";
    hash = "sha256-O0GRk81at8bgv+/4au8A55dZK2A28+ghy3sitAAZQBI=";
  };

  build-system = [ hatchling ];

  dependencies = [
    anyio
    pycrdt
    sqlite-anyio
  ];

  optional-dependencies = {
    django = [ channels ];
  };

  pythonImportsCheck = [ "pycrdt_websocket" ];

  nativeCheckInputs = [
    httpx-ws
    hypercorn
    pytest-asyncio
    pytestCheckHook
    trio
    uvicorn
    websockets
  ];

  disabledTestPaths = [
    # requires nodejs and installed js modules
    "tests/test_pycrdt_yjs.py"
  ];

  __darwinAllowLocalNetworking = true;

  meta = {
    description = "WebSocket Connector for pycrdt";
    homepage = "https://github.com/jupyter-server/pycrdt-websocket";
    changelog = "https://github.com/jupyter-server/pycrdt-websocket/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = lib.teams.jupyter.members;
  };
}
