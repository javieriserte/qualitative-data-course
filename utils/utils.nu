# Encrypt a file with AES-256-CBC and encode the result as base64.
# Usage: bencrypt input.txt output.enc
export def bencrypt [
    input: path,   # plaintext input file
    output: path,  # base64-encoded encrypted output file
] {
    let pass = (input --suppress-output "Encryption passphrase: ")
    with-env { BENC_PASS: $pass } {
        open --raw $input
            | ^openssl enc -aes-256-cbc -pbkdf2 -pass env:BENC_PASS
            | encode base64
            | save --force $output
    }
}

# Decode base64 and decrypt a file produced by bencrypt.
# Usage: bdecrypt input.enc output.txt
export def bdecrypt [
    input: path,   # base64-encoded encrypted input file
    output: path,  # decrypted plaintext output file
] {
    let pass = (input --suppress-output "Decryption passphrase: ")
    with-env { BENC_PASS: $pass } {
        open --raw $input
            | decode base64
            | ^openssl enc -d -aes-256-cbc -pbkdf2 -pass env:BENC_PASS
            | save --force $output
    }
}
