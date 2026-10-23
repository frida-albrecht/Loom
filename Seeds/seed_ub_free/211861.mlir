module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3> : tensor<5x5x2xi8>}> : () -> tensor<5x5x2xi8>
    %1 = "tosa.const"() <{values = dense<1> : tensor<1x1x2xi8>}> : () -> tensor<1x1x2xi8>
    %2 = tosa.logical_right_shift %0, %1 : (tensor<5x5x2xi8>, tensor<1x1x2xi8>) -> tensor<5x5x2xi8>
    %3 = tosa.reduce_max %2 {axis = 2 : i32} : (tensor<5x5x2xi8>) -> tensor<5x5x1xi8>
    %cast = tensor.cast %3 : tensor<5x5x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

