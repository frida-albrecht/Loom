module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<-40> : tensor<1x2xi32>}> : () -> tensor<1x2xi32>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.pad %0, %2, %3 : (tensor<1xi8>, !tosa.shape<2>, tensor<1xi8>) -> tensor<1xi8>
    %5 = tosa.reduce_max %4 {axis = 0 : i32} : (tensor<1xi8>) -> tensor<1xi8>
    %cast = tensor.cast %5 : tensor<1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

