module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<28> : tensor<3xi64>}> : () -> tensor<3xi64>
    %1 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %2 = tosa.tile %0, %1 : (tensor<3xi64>, !tosa.shape<1>) -> tensor<6xi64>
    %cast = tensor.cast %2 : tensor<6xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

