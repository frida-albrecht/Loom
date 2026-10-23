module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-82.4499969> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = "tosa.const"() <{values = dense<-13> : tensor<2x1xi8>}> : () -> tensor<2x1xi8>
    %2 = "tosa.const"() <{values = dense<8> : tensor<1x1xi8>}> : () -> tensor<1x1xi8>
    %3 = tosa.log %0 : (tensor<2xf32>) -> tensor<2xf32>
    %4 = tosa.reduce_product %3 {axis = 0 : i32} : (tensor<2xf32>) -> tensor<1xf32>
    %5 = tosa.maximum %4, %4 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %6 = tosa.reduce_sum %5 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %7 = tosa.bitwise_and %1, %2 : (tensor<2x1xi8>, tensor<1x1xi8>) -> tensor<2x1xi8>
    %8 = tosa.argmax %6 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<i32>
    %9 = tosa.const_shape  {values = dense<[3, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %10 = tosa.tile %7, %9 : (tensor<2x1xi8>, !tosa.shape<2>) -> tensor<6x1xi8>
    %cast = tensor.cast %8 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<6x1xi8> to tensor<*xi8>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

