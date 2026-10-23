module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.794600e+02> : tensor<6x10x1xf32>}> : () -> tensor<6x10x1xf32>
    %1 = tosa.const_shape  {values = dense<[3, 20]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.reshape %0, %1 : (tensor<6x10x1xf32>, !tosa.shape<2>) -> tensor<3x20xf32>
    %cast = tensor.cast %2 : tensor<3x20xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

