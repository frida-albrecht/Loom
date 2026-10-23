module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6> : tensor<5x7xi8>}> : () -> tensor<5x7xi8>
    %1 = "tosa.const"() <{values = dense<-20> : tensor<1x7xi8>}> : () -> tensor<1x7xi8>
    %2 = tosa.equal %0, %1 : (tensor<5x7xi8>, tensor<1x7xi8>) -> tensor<5x7xi1>
    %3 = "tosa.const"() <{values = dense<false> : tensor<1xi1>}> : () -> tensor<1xi1>
    %4 = "tosa.const"() <{values = dense<false> : tensor<1xi1>}> : () -> tensor<1xi1>
    %5 = tosa.negate %2, %3, %4 : (tensor<5x7xi1>, tensor<1xi1>, tensor<1xi1>) -> tensor<5x7xi1>
    %6 = tosa.const_shape  {values = dense<[35, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %7 = tosa.reshape %5, %6 : (tensor<5x7xi1>, !tosa.shape<2>) -> tensor<35x1xi1>
    %8 = tosa.sub %7, %7 : (tensor<35x1xi1>, tensor<35x1xi1>) -> tensor<35x1xi1>
    %9 = tosa.logical_xor %8, %7 : (tensor<35x1xi1>, tensor<35x1xi1>) -> tensor<35x1xi1>
    %10 = tosa.argmax %9 {axis = 1 : i32} : (tensor<35x1xi1>) -> tensor<35xi32>
    %11 = tosa.reduce_sum %10 {axis = 0 : i32} : (tensor<35xi32>) -> tensor<1xi32>
    %cast = tensor.cast %11 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

