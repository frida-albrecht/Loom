module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8.261000e+01> : tensor<3x5x8xf32>}> : () -> tensor<3x5x8xf32>
    %1 = tosa.log %0 : (tensor<3x5x8xf32>) -> tensor<3x5x8xf32>
    %2 = tosa.rsqrt %1 : (tensor<3x5x8xf32>) -> tensor<3x5x8xf32>
    %cast = tensor.cast %2 : tensor<3x5x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

