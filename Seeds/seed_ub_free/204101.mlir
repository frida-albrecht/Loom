module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<17> : tensor<1x3x1x8xi8>}> : () -> tensor<1x3x1x8xi8>
    %1 = tosa.clamp %0 {max_val = 53 : i8, min_val = -10 : i8} : (tensor<1x3x1x8xi8>) -> tensor<1x3x1x8xi8>
    %2 = tosa.argmax %1 {axis = 0 : i32} : (tensor<1x3x1x8xi8>) -> tensor<3x1x8xi32>
    %cast = tensor.cast %2 : tensor<3x1x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

