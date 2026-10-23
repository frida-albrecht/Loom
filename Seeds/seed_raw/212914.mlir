module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<1.552100e+02> : tensor<9x7xf32>}> : () -> tensor<9x7xf32>
    %2 = "tosa.const"() <{values = dense<-1.504300e+02> : tensor<9x1xf32>}> : () -> tensor<9x1xf32>
    %3 = tosa.clz %0 : (tensor<i64>) -> tensor<i64>
    %4 = tosa.pow %1, %2 : (tensor<9x7xf32>, tensor<9x1xf32>) -> tensor<9x7xf32>
    %5 = tosa.sub %3, %3 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %8 = tosa.negate %5, %6, %7 : (tensor<i64>, tensor<1xi64>, tensor<1xi64>) -> tensor<i64>
    %9 = tosa.const_shape  {values = dense<3> : tensor<2xindex>} : () -> !tosa.shape<2>
    %10 = tosa.tile %4, %9 : (tensor<9x7xf32>, !tosa.shape<2>) -> tensor<27x21xf32>
    %cast = tensor.cast %8 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %10 : tensor<27x21xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

