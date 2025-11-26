variable "TAG" {
  default = "slim"
}

variable "REGISTRY" {
  default = "nxndev"
}

# Common settings for all targets
target "common" {
  context = "."
  platforms = ["linux/amd64"]
  args = {
    BUILDKIT_INLINE_CACHE = "1"
  }
}

# Regular ComfyUI image (CUDA 12.4)
target "regular" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  tags = [
    "${REGISTRY}/comfyui:${TAG}",
    "${REGISTRY}/comfyui:latest",
  ]
}

# Dev image for local testing
target "dev" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  tags = ["${REGISTRY}/comfyui:dev"]
  output = ["type=docker"]
}

# Dev push targets (for CI pushing dev tags, without overriding latest)
target "devpush" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  tags = ["${REGISTRY}/comfyui:dev"]
}

target "devpush5090" {
  inherits = ["common"]
  dockerfile = "Dockerfile.5090"
  tags = ["${REGISTRY}/comfyui:dev-5090"]
}

# RTX 5090 optimized image (CUDA 12.8 + latest PyTorch build)
target "rtx5090" {
  inherits = ["common"]
  dockerfile = "Dockerfile.5090"
  args = {
    START_SCRIPT = "start.5090.sh"
  }
  tags = [
    "${REGISTRY}/comfyui:${TAG}-5090",
    "${REGISTRY}/comfyui:latest-5090",
  ]
}

# Build all images
group "all" {
  targets = ["regular", "rtx5090"]
}
