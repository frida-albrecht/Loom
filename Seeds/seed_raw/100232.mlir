module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.817500e+02> : tensor<16x8xf16>}> : () -> tensor<16x8xf16>
    %1 = "tosa.const"() <{values = dense<1.397300e+02> : tensor<8x32xf64>}> : () -> tensor<8x32xf64>
    %2 = "tosa.const"() <{values = dense<-9.78999996> : tensor<16x32xf32>}> : () -> tensor<16x32xf32>
    %3 = linalg.matmul ins(%0, %1 : tensor<16x8xf16>, tensor<8x32xf64>) outs(%2 : tensor<16x32xf32>) -> tensor<16x32xf32>
    %cast = tensor.cast %3 : tensor<16x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

