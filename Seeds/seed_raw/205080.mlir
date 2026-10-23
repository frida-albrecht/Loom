module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.493000e+01> : tensor<3x8xf32>}> : () -> tensor<3x8xf32>
    %1 = "tosa.const"() <{values = dense<7.196000e+01> : tensor<3x1xf32>}> : () -> tensor<3x1xf32>
    %2 = tosa.sub %0, %1 : (tensor<3x8xf32>, tensor<3x1xf32>) -> tensor<3x8xf32>
    %3 = tosa.abs %2 : (tensor<3x8xf32>) -> tensor<3x8xf32>
    %cast = tensor.cast %3 : tensor<3x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

