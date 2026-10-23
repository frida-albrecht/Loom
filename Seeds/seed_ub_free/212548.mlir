module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.950800e+02> : tensor<2x4x9xf32>}> : () -> tensor<2x4x9xf32>
    %1 = tosa.sigmoid %0 : (tensor<2x4x9xf32>) -> tensor<2x4x9xf32>
    %cast = tensor.cast %1 : tensor<2x4x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

