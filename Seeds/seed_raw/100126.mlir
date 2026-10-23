module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.986200e+02> : tensor<16x64x256xf32>}> : () -> tensor<16x64x256xf32>
    %1 = tensor.empty() : tensor<16x64x256xf32>
    %2 = linalg.softmax dimension(1) ins(%0 : tensor<16x64x256xf32>) outs(%1 : tensor<16x64x256xf32>) -> tensor<16x64x256xf32>
    %cast = tensor.cast %0 : tensor<16x64x256xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

