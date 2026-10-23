module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<24> : tensor<4xi64>}> : () -> tensor<4xi64>
    %1 = "tosa.const"() <{values = dense<-85> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<195> : tensor<i32>}> : () -> tensor<i32>
    %3 = tosa.const_shape  {values = dense<3> : tensor<1xindex>} : () -> !tosa.shape<1>
    %4 = tosa.tile %0, %3 : (tensor<4xi64>, !tosa.shape<1>) -> tensor<12xi64>
    %5 = tosa.intdiv %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %6 = tosa.clamp %4 {max_val = 69 : i64, min_val = -29 : i64} : (tensor<12xi64>) -> tensor<12xi64>
    %cast = tensor.cast %5 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<12xi64> to tensor<*xi64>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

