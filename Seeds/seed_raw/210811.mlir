module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.545000e+01> : tensor<6x2x7x3xf32>}> : () -> tensor<6x2x7x3xf32>
    %1 = tosa.exp %0 : (tensor<6x2x7x3xf32>) -> tensor<6x2x7x3xf32>
    %2 = tosa.reduce_min %1 {axis = 2 : i32} : (tensor<6x2x7x3xf32>) -> tensor<6x2x1x3xf32>
    %cast = tensor.cast %2 : tensor<6x2x1x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

