module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.271000e+01> : tensor<3x9x6xf32>}> : () -> tensor<3x9x6xf32>
    %1 = tosa.const_shape  {values = dense<[54, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.reshape %0, %1 : (tensor<3x9x6xf32>, !tosa.shape<2>) -> tensor<54x3xf32>
    %cast = tensor.cast %2 : tensor<54x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

