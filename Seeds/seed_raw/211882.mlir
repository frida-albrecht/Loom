module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8.397000e+01> : tensor<9xf32>}> : () -> tensor<9xf32>
    %1 = tosa.rsqrt %0 : (tensor<9xf32>) -> tensor<9xf32>
    %cast = tensor.cast %1 : tensor<9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

