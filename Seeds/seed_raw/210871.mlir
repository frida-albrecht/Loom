module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.192400e+02> : tensor<10x4xf32>}> : () -> tensor<10x4xf32>
    %1 = "tosa.const"() <{values = dense<-189> : tensor<i64>}> : () -> tensor<i64>
    %2 = "tosa.const"() <{values = dense<-29> : tensor<i64>}> : () -> tensor<i64>
    %3 = tosa.log %0 : (tensor<10x4xf32>) -> tensor<10x4xf32>
    %4 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = tosa.tile %3, %4 : (tensor<10x4xf32>, !tosa.shape<2>) -> tensor<10x4xf32>
    %6 = tosa.logical_right_shift %1, %2 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %7 = tosa.reduce_min %5 {axis = 1 : i32} : (tensor<10x4xf32>) -> tensor<10x1xf32>
    %8 = tosa.argmax %7 {axis = 1 : i32} : (tensor<10x1xf32>) -> tensor<10xi32>
    %cast = tensor.cast %6 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %8 : tensor<10xi32> to tensor<*xi32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

