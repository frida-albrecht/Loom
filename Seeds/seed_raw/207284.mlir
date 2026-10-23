module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<117> : tensor<8x7x8x9xi32>}> : () -> tensor<8x7x8x9xi32>
    %1 = tosa.clamp %0 {max_val = 111 : i32, min_val = 63 : i32} : (tensor<8x7x8x9xi32>) -> tensor<8x7x8x9xi32>
    %2 = tosa.minimum %1, %1 : (tensor<8x7x8x9xi32>, tensor<8x7x8x9xi32>) -> tensor<8x7x8x9xi32>
    %3 = "tosa.const"() <{values = dense<[3, 0, 2, 1]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %4 = tosa.transpose %2 {perms = array<i32: 3, 0, 2, 1>} : (tensor<8x7x8x9xi32>) -> tensor<9x8x8x7xi32>
    %5 = tosa.argmax %4 {axis = 0 : i32} : (tensor<9x8x8x7xi32>) -> tensor<8x8x7xi32>
    %cast = tensor.cast %5 : tensor<8x8x7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

