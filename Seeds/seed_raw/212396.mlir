module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8> : tensor<10x7xi8>}> : () -> tensor<10x7xi8>
    %1 = "tosa.const"() <{values = dense<-112> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-68> : tensor<i32>}> : () -> tensor<i32>
    %3 = tosa.reduce_max %0 {axis = 1 : i32} : (tensor<10x7xi8>) -> tensor<10x1xi8>
    %4 = tosa.intdiv %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %3 : tensor<10x1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

