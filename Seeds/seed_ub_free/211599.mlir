module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-145> : tensor<4x1x3xi64>}> : () -> tensor<4x1x3xi64>
    %1 = tosa.const_shape  {values = dense<[2, 1, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.tile %0, %1 : (tensor<4x1x3xi64>, !tosa.shape<3>) -> tensor<8x1x3xi64>
    %cast = tensor.cast %2 : tensor<8x1x3xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

