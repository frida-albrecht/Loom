module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9.141000e+01> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %1 = tosa.rsqrt %0 : (tensor<1x1xf32>) -> tensor<1x1xf32>
    %cast = tensor.cast %1 : tensor<1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

