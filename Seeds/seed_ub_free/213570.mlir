module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<17> : tensor<5x5x7xi8>}> : () -> tensor<5x5x7xi8>
    %1 = "tosa.const"() <{values = dense<-141> : tensor<10xi32>}> : () -> tensor<10xi32>
    %2 = "tosa.const"() <{values = dense<-141> : tensor<10xi32>}> : () -> tensor<10xi32>
    %3 = tosa.bitwise_not %0 : (tensor<5x5x7xi8>) -> tensor<5x5x7xi8>
    %4 = tosa.intdiv %1, %2 : (tensor<10xi32>, tensor<10xi32>) -> tensor<10xi32>
    %5 = tosa.reduce_max %4 {axis = 0 : i32} : (tensor<10xi32>) -> tensor<1xi32>
    %6 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %7 = tosa.tile %5, %6 : (tensor<1xi32>, !tosa.shape<1>) -> tensor<2xi32>
    %8 = tosa.minimum %3, %3 : (tensor<5x5x7xi8>, tensor<5x5x7xi8>) -> tensor<5x5x7xi8>
    %9 = tosa.clz %8 : (tensor<5x5x7xi8>) -> tensor<5x5x7xi8>
    %10 = tosa.reduce_max %7 {axis = 0 : i32} : (tensor<2xi32>) -> tensor<1xi32>
    %cast = tensor.cast %9 : tensor<5x5x7xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %10 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

