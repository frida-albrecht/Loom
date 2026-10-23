module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-166> : tensor<3x6x1x5xi64>}> : () -> tensor<3x6x1x5xi64>
    %1 = tosa.const_shape  {values = dense<[1, 3, 3, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.tile %0, %1 : (tensor<3x6x1x5xi64>, !tosa.shape<4>) -> tensor<3x18x3x10xi64>
    %cast = tensor.cast %2 : tensor<3x18x3x10xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

