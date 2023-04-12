resource "google_kms_key_ring" "capstone_keyring" {
  name     = "capstone-keyring"
  location = "us-central1"
}

resource "google_kms_crypto_key" "capstone_key" {
  name            = "capstone-key"
  key_ring        = google_kms_key_ring.capstone_keyring.id
  rotation_period = "864000s"

  lifecycle {
    prevent_destroy = true
  }
}
