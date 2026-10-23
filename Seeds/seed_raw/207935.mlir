module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-11> : tensor<5xi32>}> : () -> tensor<5xi32>
    %1 = "tosa.const"() <{values = dense<-145> : tensor<6x7x8xi16>}> : () -> tensor<6x7x8xi16>
    %2 = tosa.argmax %0 {axis = 0 : i32} : (tensor<5xi32>) -> tensor<i32>
    %3 = tosa.reduce_max %1 {axis = 0 : i32} : (tensor<6x7x8xi16>) -> tensor<1x7x8xi16>
    %cast = tensor.cast %2 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %3 : tensor<1x7x8xi16> to tensor<*xi16>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

