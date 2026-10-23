module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<83> : tensor<3x2x5x5xi32>}> : () -> tensor<3x2x5x5xi32>
    %1 = tosa.reduce_product %0 {axis = 3 : i32} : (tensor<3x2x5x5xi32>) -> tensor<3x2x5x1xi32>
    %cast = tensor.cast %1 : tensor<3x2x5x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

