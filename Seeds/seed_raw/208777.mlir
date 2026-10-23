module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<181> : tensor<1x5x6x5xi64>}> : () -> tensor<1x5x6x5xi64>
    %1 = "tosa.const"() <{values = dense<-37> : tensor<5x5x3xi32>}> : () -> tensor<5x5x3xi32>
    %2 = "tosa.const"() <{values = dense<175> : tensor<5x1x1xi32>}> : () -> tensor<5x1x1xi32>
    %3 = tosa.clz %0 : (tensor<1x5x6x5xi64>) -> tensor<1x5x6x5xi64>
    %4 = tosa.intdiv %1, %2 : (tensor<5x5x3xi32>, tensor<5x1x1xi32>) -> tensor<5x5x3xi32>
    %5 = tosa.const_shape  {values = dense<[15, 10]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %6 = tosa.reshape %3, %5 : (tensor<1x5x6x5xi64>, !tosa.shape<2>) -> tensor<15x10xi64>
    %7 = tosa.reduce_max %4 {axis = 0 : i32} : (tensor<5x5x3xi32>) -> tensor<1x5x3xi32>
    %8 = tosa.identity %7 : (tensor<1x5x3xi32>) -> tensor<1x5x3xi32>
    %9 = tosa.add %6, %6 : (tensor<15x10xi64>, tensor<15x10xi64>) -> tensor<15x10xi64>
    %10 = tosa.maximum %9, %9 : (tensor<15x10xi64>, tensor<15x10xi64>) -> tensor<15x10xi64>
    %cast = tensor.cast %8 : tensor<1x5x3xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<15x10xi64> to tensor<*xi64>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

