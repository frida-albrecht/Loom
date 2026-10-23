module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-22> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<64> : tensor<i64>}> : () -> tensor<i64>
    %2 = "tosa.const"() <{values = dense<116> : tensor<3x10x6xi32>}> : () -> tensor<3x10x6xi32>
    %3 = tosa.sub %0, %1 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %4 = tosa.const_shape  {values = dense<[2, 3, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %5 = tosa.tile %2, %4 : (tensor<3x10x6xi32>, !tosa.shape<3>) -> tensor<6x30x6xi32>
    %cast = tensor.cast %3 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<6x30x6xi32> to tensor<*xi32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

