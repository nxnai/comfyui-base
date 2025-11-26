[![Watch the video](https://i3.ytimg.com/vi/JovhfHhxqdM/hqdefault.jpg)](https://www.youtube.com/watch?v=JovhfHhxqdM)

Run the latest ComfyUI. First start installs dependencies (takes a few minutes), then when you see this in the logs, ComfyUI is ready to be used: `[ComfyUI-Manager] All startup tasks have been completed.`

## Commands

```bash
# build
docker buildx bake regular        # Dockerfile → nxndev/comfyui:slim, :latest
docker buildx bake rtx5090        # Dockerfile.5090 → nxndev/comfyui:slim-5090, :latest-5090
docker buildx bake custom         # Dockerfile.custom → nxndev/comfyui:slim, :latest
docker buildx bake custom-5090    # Dockerfile.custom-5090 → nxndev/comfyui:slim-5090, :latest-5090
docker buildx bake dev            # Dockerfile → nxndev/comfyui:dev (local test)
docker buildx bake devpush        # Dockerfile → nxndev/comfyui:dev
docker buildx bake devpush5090    # Dockerfile.5090 → nxndev/comfyui:dev-5090

# group build
docker buildx bake all            # regular + rtx5090 (full build)
docker buildx bake custom-all     # custom + custom-5090 (custom light build < recommanded)

# options
--push                            # push to the docker hub
--no-cache                        # without cache
```

## Access

- `8188`: ComfyUI web UI
- `8080`: FileBrowser (admin / adminadmin12)
- `8888`: JupyterLab (token via `JUPYTER_PASSWORD`, root at `/workspace`)
- `22`: SSH (set `PUBLIC_KEY` or check logs for generated root password)

## Pre-installed custom nodes

- ComfyUI-Manager
- ComfyUI-KJNodes
- Civicomfy

## Custom Arguments

Edit `/workspace/runpod-slim/comfyui_args.txt` (one arg per line):

```
--max-batch-size 8
--preview-method auto
```

## Directory Structure

- `/workspace/runpod-slim/ComfyUI`: ComfyUI install
- `/workspace/runpod-slim/comfyui_args.txt`: ComfyUI args
- `/workspace/runpod-slim/filebrowser.db`: FileBrowser DB
