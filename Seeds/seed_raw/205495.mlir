module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.743200e+02> : tensor<4x6x8x2xf32>}> : () -> tensor<4x6x8x2xf32>
    %1 = tosa.sigmoid %0 : (tensor<4x6x8x2xf32>) -> tensor<4x6x8x2xf32>
    %2 = tosa.sigmoid %1 : (tensor<4x6x8x2xf32>) -> tensor<4x6x8x2xf32>
    %3 = tosa.sigmoid %2 : (tensor<4x6x8x2xf32>) -> tensor<4x6x8x2xf32>
    %cast = tensor.cast %3 : tensor<4x6x8x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

